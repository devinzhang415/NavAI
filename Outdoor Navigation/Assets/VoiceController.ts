type AudioFrameData = {
    audioFrame: Float32Array;
    audioFrameShape: vec3;
};

// Custom Base64 encoding implementation without using btoa
function arrayBufferToBase64(buffer: ArrayBuffer): string {
    const bytes = new Uint8Array(buffer);
    const base64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    let result = '';
    let i;
    
    // Process every 3 bytes (24 bits) into 4 ASCII characters
    for (i = 0; i < bytes.length; i += 3) {
        // Combine 3 bytes into a single integer
        const triplet = (bytes[i] << 16) | 
                      ((i + 1 < bytes.length) ? bytes[i + 1] << 8 : 0) | 
                      ((i + 2 < bytes.length) ? bytes[i + 2] : 0);
        
        // Extract 4 groups of 6 bits each and convert to Base64 characters
        for (let j = 0; j < 4; j++) {
            // If we're at the end of the input and have fewer than 3 bytes,
            // we may need to add padding
            if (i * 8 + j * 6 >= bytes.length * 8) {
                result += '=';
            } else {
                // Extract 6 bits and use as index into base64Chars
                const index = (triplet >>> (6 * (3 - j))) & 0x3F;
                result += base64Chars[index];
            }
        }
    }
    
    return result;
}

const SAMPLE_RATE = 44100;

@component
export class VoiceController extends BaseScriptComponent {
    @input
    microphoneAsset: AudioTrackAsset;

    @input
    audioOutput: AudioTrackAsset;

    @input remoteServiceModule: RemoteServiceModule;

    @input
    @allowUndefined
    debugText: Text;

    private audioComponent: AudioComponent;
    private recordAudioUpdateEvent: UpdateEvent;
    private playbackAudioUpdateEvent: UpdateEvent;

    private microphoneControl: MicrophoneAudioProvider;
    private audioOutputProvider: AudioOutputProvider;

    private recordedAudioFrames: AudioFrameData[] = [];

    private numberOfSamples: number = 0;
    private _recordingDuration: number = 0;

    private currentPlaybackTime: number = 0;
    private iterations: number = 0;

    onAwake() {
        // Initialize microphone control and set sample rate
        this.microphoneControl = this.microphoneAsset
        .control as MicrophoneAudioProvider;
        this.microphoneControl.sampleRate = SAMPLE_RATE;

        // Create and configure audio component
        this.audioComponent = this.sceneObject.createComponent("AudioComponent");
        this.audioComponent.audioTrack = this.audioOutput;
        this.audioOutputProvider = this.audioOutput.control as AudioOutputProvider;
        this.audioOutputProvider.sampleRate = SAMPLE_RATE;

        // Create and bind record audio update event
        this.recordAudioUpdateEvent = this.createEvent("UpdateEvent");
        this.recordAudioUpdateEvent.bind(() => {
            this.onRecordAudio();
        });
        this.recordAudioUpdateEvent.enabled = true;

        // Create and bind playback audio update event
        this.playbackAudioUpdateEvent = this.createEvent("UpdateEvent");
        this.playbackAudioUpdateEvent.bind(() => {
            this.onPlaybackAudio();
        });
        this.playbackAudioUpdateEvent.enabled = false;
        this.iterations = 0;
    }

    async sendAudioForRecognition() {
        if (this.recordedAudioFrames.length <= 0) {
            print("No audio recorded to send");
            return;
        }
        
        // Combine all recorded audio frames into a single array
        let totalLength = 0;
        for (const frame of this.recordedAudioFrames) {
            totalLength += frame.audioFrame.length;
        }
        
        // Create a new array to hold all the audio data
        const combinedAudio = new Float32Array(totalLength);
        
        // Copy all frames into the combined array
        let offset = 0;
        for (const frame of this.recordedAudioFrames) {
            combinedAudio.set(frame.audioFrame, offset);
            offset += frame.audioFrame.length;
        }
        
        // Convert Float32Array to Int16Array (common format for speech recognition)
        // This maps the float range [-1.0, 1.0] to int16 range [-32768, 32767]
        const int16Audio = new Int16Array(combinedAudio.length);
        for (let i = 0; i < combinedAudio.length; i++) {
            int16Audio[i] = Math.max(-32768, Math.min(32767, Math.floor(combinedAudio[i] * 32767)));
        }
        
        // Send the audio data to your speech recognition API
        try {
           const google_api_key = 'AIzaSyAZvjI98_CY3XPnVlPgCuI0Z3i3YgehhZ0';
           const stringSound = arrayBufferToBase64(int16Audio);
           const request = new Request(`https://speech.googleapis.com/v1/speech:recognize?key=${google_api_key}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    'config': {
                        'encoding': 'FLAC',
                        'sampleRateHertz': 16000,
                        'languageCode': 'en-US'
                    },
                    'audio': {
                        'content': stringSound
                    }
                })
           });

            
            let response = await this.remoteServiceModule.fetch(request);
            if (!response.ok) {
                print(response.status)
            }

            const responseText = await response.json();
            print("Received response text " + responseText['results']);
            print("hmm okay")
        } catch (error) {
            print("Error sending audio for recognition: " + JSON.stringify(error));
            return null;
        }
    }

    // Called to record audio from the microphone
    private onRecordAudio() {
        let frameSize: number = this.microphoneControl.maxFrameSize;
        let audioFrame = new Float32Array(frameSize);

        // Get audio frame shape
        const audioFrameShape = this.microphoneControl.getAudioFrame(audioFrame);

        // If no audio data, return early
        if (audioFrameShape.x === 0) {
            return;
        }

        // Reduce the initial subarray size to the audioFrameShape value
        audioFrame = audioFrame.subarray(0, audioFrameShape.x);
        
        // Update the number of samples and recording duration
        this.numberOfSamples += audioFrameShape.x;
        this._recordingDuration = this.numberOfSamples / SAMPLE_RATE;

        // Update debug text with recording information
        this.updateRecordingDebugText();

        // Store the recorded audio frame
        this.recordedAudioFrames.push({
            audioFrame: audioFrame,
            audioFrameShape: audioFrameShape,
        });

        if (this.iterations == 35) {
            this.sendAudioForRecognition();
            this.iterations = 0;
        }
        this.iterations += 1;
        print("HIHIHIHIHIHI");
    }

    // Called to handle playback of recorded audio
    private onPlaybackAudio() {
        this.currentPlaybackTime += getDeltaTime();
        this.currentPlaybackTime = Math.min(
            this.currentPlaybackTime,
            this._recordingDuration
        );

        // Update debug text with playback information
        this.updatePlaybackDebugText();

        // Stop playback if the end of the recording is reached
        if (this.currentPlaybackTime >= this._recordingDuration) {
            this.audioComponent.stop(false);
            this.playbackAudioUpdateEvent.enabled = false;
        }
    }

    // Update the debug text with recording information
    updateRecordingDebugText() {
        if (isNull(this.debugText)) {
            return;
        }

        this.debugText.text = "Duration: " + this._recordingDuration.toFixed(1) + "s";
        this.debugText.text += "\n Size: " + (this.getTotalRecordedBytes() / 1000).toFixed(1) + "kB";
        this.debugText.text += "\nSample Rate: " + SAMPLE_RATE;
    }

    // Update the debug text with playback information
    updatePlaybackDebugText() {
        if (this.numberOfSamples <= 0) {
            this.debugText.text =
                "Oops! \nNo audio has been recorded yet. Please try recording again.";
            return;
        }
        
        // this.debugText.text = "Playback Time: \n";
        // this.debugText.text +=
        // this.currentPlaybackTime.toFixed(1) +
        // "s / " +
        // this._recordingDuration.toFixed(1) +
        // "s";
    }

    // Start or stop recording audio from the microphone
    recordMicrophoneAudio(toRecord: boolean) {
        if (toRecord) {
            this.recordedAudioFrames = [];
            this.audioComponent.stop(false);
            this.numberOfSamples = 0;
            this.microphoneControl.start();
            this.recordAudioUpdateEvent.enabled = true;
            this.playbackAudioUpdateEvent.enabled = false;
        } else {
            this.microphoneControl.stop();
            this.recordAudioUpdateEvent.enabled = false;
            this.sendAudioForRecognition();
        }
    }

    // Start playback of the recorded audio
    playbackRecordedAudio(): boolean {
        this.updatePlaybackDebugText();
        if (this.recordedAudioFrames.length <= 0) {
            return false;
        }
        this.currentPlaybackTime = 0;
        this.audioComponent.stop(false);
        this.playbackAudioUpdateEvent.enabled = true;
        this.audioComponent.play(-1);
        for (let i = 0; i < this.recordedAudioFrames.length; i++) {
            this.audioOutputProvider.enqueueAudioFrame(
                this.recordedAudioFrames[i].audioFrame,
                this.recordedAudioFrames[i].audioFrameShape
            );
        }
        return true;
    }

    // Getter for recording duration
    public get recordingDuration(): number {
        return this._recordingDuration;
    }

    // Calculate the total recorded bytes
    private getTotalRecordedBytes(): number {
        let totalBytes = 0;
        for (const frame of this.recordedAudioFrames) {
            totalBytes += frame.audioFrame.byteLength;
        }
        return totalBytes;
    }
}