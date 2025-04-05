require("LensStudio:RawLocationModule");

import { MapComponent } from "../MapComponent/Scripts/MapComponent";
import { makeTween } from "../MapComponent/Scripts/MapUtils";
import { ContainerFrame } from "../SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame";
import { PinchButton } from "../SpectaclesInteractionKit/Components/UI/PinchButton/PinchButton";
import { ToggleButton } from "../SpectaclesInteractionKit/Components/UI/ToggleButton/ToggleButton";
import { InteractorEvent } from "../SpectaclesInteractionKit/Core/Interactor/InteractorEvent";
import { CancelFunction } from "../SpectaclesInteractionKit/Utils/animate";
import NativeLogger from "../SpectaclesInteractionKit/Utils/NativeLogger";
import { setNearbyPlacesRange } from "../MapComponent/Scripts/PlacesConfig";

export const TWEEN_DURATION = 0.3;
const ZOOM_IN_BUTTON_OFFSET_MINI = new vec3(7, -9.5, 2);
const ZOOM_IN_BUTTON_OFFSET_FULL = new vec3(22.8488, -32, 2);
const ZOOM_OUT_BUTTON_OFFSET_MINI = new vec3(-7, -9.5, 2);
const ZOOM_OUT_BUTTON_OFFSET_FULL = new vec3(17.5945, -32, 2);
const CENTER_MAP_BUTTON_OFFSET_MINI = new vec3(0, -10, 2);
const CENTER_MAP_BUTTON_OFFSET_FULL = new vec3(9, -32, 2);
const TOGGLE_BUTTON_OFFSET_MINI = new vec3(-10, 10.5, 2);
const TOGGLE_BUTTON_OFFSET_FULL = new vec3(-31, 32, 2);
const RANGE_BUTTON_OFFSET_MINI = new vec3(10, 10.5, 2);
const RANGE_BUTTON_OFFSET_FULL = new vec3(31, 32, 2);

enum ButtonType {
  SPAWN_PIN,
  CLEAR_PINS,
  ZOOM_IN,
  ZOOM_OUT,
  CENTER_MAP,
  TOGGLE_MINI_MAP,
  SHOW_CAFE,
  SHOW_BARS,
  SHOW_RESTAURANTS,
  RANGE_SELECTION,
}

const TAG = "[MapUIController]";
const log = new NativeLogger(TAG);

@component
export class MapUIController extends BaseScriptComponent {
  @input
  private mapComponent: MapComponent;

  @input
  private spawnPinButton: PinchButton;
  @input
  private clearPinsButton: PinchButton;
  @input
  private zoomInButton: PinchButton;
  @input
  private zoomOutButton: PinchButton;
  @input
  private centerMapButton: PinchButton;

  @input
  private toggleMiniMapButton: ToggleButton;

  @input
  private showRestaurantsButton: PinchButton;
  @input
  private showCafeButton: PinchButton;
  @input
  private showBarsButton: PinchButton;
  @input
  private rangeSelectionButton: PinchButton;
  @input
  private range100Button: PinchButton;
  @input
  private range400Button: PinchButton;
  @input
  private range800Button: PinchButton;

  // For debugging
  @input
  @allowUndefined
  private logObject: SceneObject;

  private buttonTransforms: Transform[];

  private isMiniMap: boolean = true;

  private tweenCancelFunction: CancelFunction;
  private rangeDropdownVisible: boolean = false;

  onAwake() {
    this.createEvent("OnStartEvent").bind(this.onStart.bind(this));
  }

  private onStart() {
    this.spawnPinButton.onButtonPinched.add(
      this.handleSpawnPinButtonPinched.bind(this)
    );
    this.clearPinsButton.onButtonPinched.add(
      this.handleClearPinsButtonPinched.bind(this)
    );
    this.zoomInButton.onButtonPinched.add(
      this.handleZoomInButtonPinched.bind(this)
    );
    this.zoomOutButton.onButtonPinched.add(
      this.handleZoomOutButtonPinched.bind(this)
    );
    this.centerMapButton.onButtonPinched.add(() =>
      this.mapComponent.centerMap()
    );
    this.toggleMiniMapButton.onStateChanged.add(
      this.handleToggleMiniMapButtonPinched.bind(this)
    );
    this.rangeSelectionButton.onButtonPinched.add(
      this.handleRangeSelectionButtonPinched.bind(this)
    );
    this.range100Button.onButtonPinched.add(() => this.handleSetRangeButtonPinched(100));
    this.range400Button.onButtonPinched.add(() => this.handleSetRangeButtonPinched(400));
    this.range800Button.onButtonPinched.add(() => this.handleSetRangeButtonPinched(800));

    this.showCafeButton.onButtonPinched.add(
      this.handleShowCafeButtonPinched.bind(this)
    );
    this.showBarsButton.onButtonPinched.add(
      this.handleShowPubsButtonPinched.bind(this)
    );
    this.showRestaurantsButton.onButtonPinched.add(
      this.handleShowRestaurantsButtonPinched.bind(this)
    );

    // Should have the same order as the ButtonType enum
    this.buttonTransforms = [
      this.spawnPinButton.getTransform(),
      this.clearPinsButton.getTransform(),
      this.zoomInButton.getTransform(),
      this.zoomOutButton.getTransform(),
      this.centerMapButton.getTransform(),
      this.toggleMiniMapButton.getTransform(),
      this.showCafeButton.getTransform(),
      this.showBarsButton.getTransform(),
      this.showRestaurantsButton.getTransform(),
      this.rangeSelectionButton.getTransform(),
      this.range100Button.getTransform(),
      this.range400Button.getTransform(),
      this.range800Button.getTransform(),
    ];

    if (this.logObject !== undefined) {
      this.buttonTransforms.push(this.logObject.getTransform());
    }

    if (this.isMiniMap) {
      this.spawnPinButton.sceneObject.enabled = false;
      this.clearPinsButton.sceneObject.enabled = false;
      this.showCafeButton.sceneObject.enabled = false;
      this.showBarsButton.sceneObject.enabled = false;
      this.showRestaurantsButton.sceneObject.enabled = false;
      this.rangeSelectionButton.sceneObject.enabled = false;
      this.hideRangeDropdown();
    }

    // Set button titles
    this.rangeSelectionButton.sceneObject.name = "Radius";
    this.range100Button.sceneObject.name = "100m";
    this.range400Button.sceneObject.name = "400m";
    this.range800Button.sceneObject.name = "800m";
  }

  private handleRangeSelectionButtonPinched(event: InteractorEvent) {
    this.toggleRangeDropdown();
  }

  private showRangeDropdown() {
    this.rangeDropdownVisible = true;
    this.range100Button.sceneObject.enabled = true;
    this.range400Button.sceneObject.enabled = true;
    this.range800Button.sceneObject.enabled = true;
  }

  private hideRangeDropdown() {
    this.rangeDropdownVisible = false;
    this.range100Button.sceneObject.enabled = false;
    this.range400Button.sceneObject.enabled = false;
    this.range800Button.sceneObject.enabled = false;
  }

  private handleSpawnPinButtonPinched(event: InteractorEvent) {
    this.mapComponent.addPinByLocalPosition(vec2.zero());
  }

  private handleClearPinsButtonPinched(event: InteractorEvent) {
    this.mapComponent.removeMapPins();
  }

  private handleZoomInButtonPinched(event: InteractorEvent) {
    this.mapComponent.zoomIn();
  }

  private handleZoomOutButtonPinched(event: InteractorEvent) {
    this.mapComponent.zoomOut();
  }

  private handleToggleMiniMapButtonPinched(isOn: boolean) {
    if (this.isMiniMap === isOn) {
      return;
    }

    log.i("Toggling minimap " + isOn);

    this.mapComponent.toggleMiniMap(isOn);
    if (this.tweenCancelFunction !== undefined) {
      this.tweenCancelFunction();
      this.tweenCancelFunction = undefined;
    }

    if (isOn) {
      this.spawnPinButton.sceneObject.enabled = false;
      this.clearPinsButton.sceneObject.enabled = false;
      this.showCafeButton.sceneObject.enabled = false;
      this.showBarsButton.sceneObject.enabled = false;
      this.showRestaurantsButton.sceneObject.enabled = false;
      this.rangeSelectionButton.sceneObject.enabled = false;
      this.hideRangeDropdown();
      this.tweenCancelFunction = makeTween((t) => {
        this.buttonTransforms[ButtonType.ZOOM_IN].setLocalPosition(
          vec3.lerp(ZOOM_IN_BUTTON_OFFSET_FULL, ZOOM_IN_BUTTON_OFFSET_MINI, t)
        );
        this.buttonTransforms[ButtonType.ZOOM_OUT].setLocalPosition(
          vec3.lerp(ZOOM_OUT_BUTTON_OFFSET_FULL, ZOOM_OUT_BUTTON_OFFSET_MINI, t)
        );
        this.buttonTransforms[ButtonType.CENTER_MAP].setLocalPosition(
          vec3.lerp(
            CENTER_MAP_BUTTON_OFFSET_FULL,
            CENTER_MAP_BUTTON_OFFSET_MINI,
            t
          )
        );
        this.buttonTransforms[ButtonType.TOGGLE_MINI_MAP].setLocalPosition(
          vec3.lerp(TOGGLE_BUTTON_OFFSET_FULL, TOGGLE_BUTTON_OFFSET_MINI, t)
        );
        this.buttonTransforms[ButtonType.RANGE_SELECTION].setLocalPosition(
          vec3.lerp(RANGE_BUTTON_OFFSET_FULL, RANGE_BUTTON_OFFSET_MINI, t)
        );
      }, TWEEN_DURATION);
    } else {
      this.tweenCancelFunction = makeTween((t) => {
        this.buttonTransforms[ButtonType.ZOOM_IN].setLocalPosition(
          vec3.lerp(ZOOM_IN_BUTTON_OFFSET_MINI, ZOOM_IN_BUTTON_OFFSET_FULL, t)
        );
        this.buttonTransforms[ButtonType.ZOOM_OUT].setLocalPosition(
          vec3.lerp(ZOOM_OUT_BUTTON_OFFSET_MINI, ZOOM_OUT_BUTTON_OFFSET_FULL, t)
        );
        this.buttonTransforms[ButtonType.CENTER_MAP].setLocalPosition(
          vec3.lerp(
            CENTER_MAP_BUTTON_OFFSET_MINI,
            CENTER_MAP_BUTTON_OFFSET_FULL,
            t
          )
        );
        this.buttonTransforms[ButtonType.TOGGLE_MINI_MAP].setLocalPosition(
          vec3.lerp(TOGGLE_BUTTON_OFFSET_MINI, TOGGLE_BUTTON_OFFSET_FULL, t)
        );
        this.buttonTransforms[ButtonType.RANGE_SELECTION].setLocalPosition(
          vec3.lerp(RANGE_BUTTON_OFFSET_MINI, RANGE_BUTTON_OFFSET_FULL, t)
        );

        if (t > 0.99999) {
          this.spawnPinButton.sceneObject.enabled = true;
          this.clearPinsButton.sceneObject.enabled = true;
          this.showCafeButton.sceneObject.enabled = true;
          this.showBarsButton.sceneObject.enabled = true;
          this.showRestaurantsButton.sceneObject.enabled = true;
          this.rangeSelectionButton.sceneObject.enabled = true;
        }
      }, TWEEN_DURATION);
    }

    this.isMiniMap = isOn;
  }

  private handleShowCafeButtonPinched(event: InteractorEvent) {
    this.mapComponent.showNeaybyPlaces(["Coffee"]);
  }

  private handleShowPubsButtonPinched(event: InteractorEvent) {
    this.mapComponent.showNeaybyPlaces(["Bar", "Pub"]);
  }

  private handleShowRestaurantsButtonPinched(event: InteractorEvent) {
    this.mapComponent.showNeaybyPlaces(["Restaurant"]);
  }

  private handleSetRangeButtonPinched(range: number) {
    setNearbyPlacesRange(range);
    this.hideRangeDropdown();
  }

  private toggleRangeDropdown() {
    if (this.rangeDropdownVisible) {
      this.hideRangeDropdown();
    } else {
      this.showRangeDropdown();
    }
  }
}
