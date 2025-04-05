import { SIK } from "SpectaclesInteractionKit/SIK";

@component
export class PinchController extends BaseScriptComponent {
    private rightHand = SIK.HandInputData.getHand("right");
    private leftHand = SIK.HandInputData.getHand("left");
    
    private leftDown : boolean;
    private rightDown : boolean;
    
    onAwake() {
        this.leftDown = false;
        this.rightDown = false;
        // Bind the update event
        this.createEvent("UpdateEvent").bind(this.update.bind(this));
        
        this.leftHand.onPinchDown.add(() => {
          this.leftDown = true;
        });
        this.rightHand.onPinchDown.add(() => {
          this.rightDown = true;
        });
        
        this.leftHand.onPinchUp.add(() => {
            this.leftDown = false;
        });
        this.rightHand.onPinchUp.add(() => {
            this.rightDown = false;
        })
    }
    
    private update() {
        print('update called');
        print(this.rightDown);
        print(this.leftDown);
        if (this.rightDown && this.leftDown) {
            print("Both Down")
        }
    }
}
