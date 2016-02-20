part of survive_game.graphics;

class BitmapUtil {

  static BitmapData withOffset(BitmapData bitmap, Math.Point offset) {
    Math.Rectangle<int> offsetRectangle = new Math.Rectangle(
        offset.x, offset.y, 0, 0);
    RenderTextureQuad sourceQuad = bitmap.renderTextureQuad;
    RenderTextureQuad offsetQuad = new RenderTextureQuad(
        sourceQuad.renderTexture, sourceQuad.sourceRectangle, offsetRectangle,
        sourceQuad.rotation, sourceQuad.pixelRatio);
    return new BitmapData.fromRenderTextureQuad(offsetQuad);
  }

}