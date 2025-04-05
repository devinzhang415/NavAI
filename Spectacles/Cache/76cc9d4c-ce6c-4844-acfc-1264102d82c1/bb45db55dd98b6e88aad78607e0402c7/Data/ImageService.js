@component
export class ImageSaver extends BaseScriptComponent {
  @input saveLocation: string = "DCIM/SpectaclesLens";
  
  private isEditor = global.deviceInfoSystem.isEditor();
  private captureCount = 0;
  
  saveImage(texture: Texture, cropRect: Rect) {
    if (this.isEditor) {
      print("Image capture simulated in editor");
      this.captureCount++;
      return;
    }
    
    try {
      // Create file name based on timestamp
      const timestamp = new Date().getTime();
      const fileName = `crop_${timestamp}_${this.captureCount++}.png`;
      const filePath = `${this.saveLocation}/${fileName}`;
      
      // Extract texture data
      const textureProvider = texture.control as TextureProvider;
      
      // Save texture to file system
      global.textureFileProvider.saveTextureToFile(
        texture,
        filePath,
        TextureFileProvider.TextureFileFormat.PNG
      );
      
      print(`Image saved to: ${filePath}`);
    } catch (e) {
      print(`Error saving image: ${e}`);
    }
  }
}