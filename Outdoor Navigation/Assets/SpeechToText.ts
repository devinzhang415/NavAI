

@component
export class SpeechToText extends BaseScriptComponent {
    
  @input()
  text: Text;
  // Remote service module for fetching data
  private voiceMLModule: VoiceMLModule = require("LensStudio:VoiceMLModule");
  private isEnabled: boolean = false;
  private displayText: string = '';

  onAwake() {
    // print("AWAKE");
    let options = VoiceML.ListeningOptions.create();
    options.shouldReturnAsrTranscription = true;
    options.shouldReturnInterimAsrTranscription = true;
    this.voiceMLModule.onListeningEnabled.add(() => {
      this.voiceMLModule.startListening(options);
      this.voiceMLModule.onListeningUpdate.add(this.onListenUpdate);
    });
  }

  containsActivation(payload: string): boolean {
    payload = payload.toLowerCase();
    const heyIndex = payload.indexOf('hey');
    const nameIndex = payload.indexOf('alex');
    return (heyIndex != -1) && (nameIndex != -1) && (heyIndex < nameIndex);
  }

  onListenUpdate = (eventData: VoiceML.ListeningUpdateEventArgs) => {
    // print(eventData.transcription);
    if (eventData.isFinalTranscription) {
        if (!this.isEnabled) {
          this.isEnabled = this.containsActivation(eventData.transcription);
        } else {
          this.isEnabled = false;
          this.text.text = '';
        }
    }
    
    if (this.isEnabled) {
        this.text.text = eventData.transcription;
    }
  };
}