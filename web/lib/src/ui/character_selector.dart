part of survive_game.ui;

class CharacterSelector extends DisplayObject {
  static final int CHARACTER_SELECTOR_LEFT_OFFSET = 5;
  static final int CHARACTER_SELECTOR_BOTTOM_OFFSET = 5;

  Screen _screen;
  List<GameCharacter> _gameCharacters;

  CharacterSelector.withCharacters(this._screen, this._gameCharacters);

  @override
  void render(RenderState renderState) {
    for (int index = 0; index < _gameCharacters.length; index++) {
      GameCharacter gameCharacter = _gameCharacters[index];
      _renderGameCharacterPreview(renderState, gameCharacter, index);
    }
  }

  void _renderGameCharacterPreview(
      RenderState renderState, GameCharacter gameCharacter, int index) {
    Map<CharacterPart, Bitmap> previewBitmaps =
        _getGameCharacterPreview(gameCharacter);
    _renderPreviewBitmaps(renderState, previewBitmaps, index);
  }

  Map<CharacterPart, Bitmap> _getGameCharacterPreview(
      GameCharacter gameCharacter) {
    Map<CharacterPart, BitmapData> preview =
        gameCharacter.animation.getPreview();
    Map<CharacterPart, Bitmap> previewBitmaps =
        new Map<CharacterPart, Bitmap>();
    for (CharacterPart characterPart in CharacterPart.VALUES) {
      previewBitmaps[characterPart] = new Bitmap(preview[characterPart]);
    }
    return previewBitmaps;
  }

  void _renderPreviewBitmaps(RenderState renderState,
      Map<CharacterPart, Bitmap> previewBitmaps, int index) {
    Bitmap bodyBitmap = previewBitmaps[CharacterPart.BODY];
    num left = CHARACTER_SELECTOR_LEFT_OFFSET +
        index * bodyBitmap.bitmapData.width +
        bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.left;
    num top = _screen.height -
        CHARACTER_SELECTOR_BOTTOM_OFFSET -
        bodyBitmap.bitmapData.height +
        bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.top;

    for (CharacterPart characterPart in CharacterPart.inRenderingOrder()) {
      Bitmap previewBitmap = previewBitmaps[characterPart];
      previewBitmap.x = left;
      previewBitmap.y = top;
      renderState.renderObject(previewBitmap);
    }
  }
}
