part of survive_game.ui;

class CharacterSelector extends DisplayObject {
  Screen _screen;
  List<GameCharacter> _gameCharacters;
  Map<GameCharacter, CharacterPreview> _characterPreviews =
      new Map<GameCharacter, CharacterPreview>();

  CharacterSelector.withCharacters(this._screen, this._gameCharacters);

  @override
  void render(RenderState renderState) {
    for (int index = 0; index < _gameCharacters.length; index++) {
      GameCharacter gameCharacter = _gameCharacters[index];
      _verifyAndRenderGameCharacterPreview(gameCharacter, index);
    }
  }

  void _verifyAndRenderGameCharacterPreview(
      GameCharacter gameCharacter, int index) {
    _verifyExistingPreview(gameCharacter);
    _renderGameCharacterPreview(gameCharacter, index);
  }

  void _verifyExistingPreview(GameCharacter gameCharacter) {
    CharacterAnimation animation = gameCharacter.animation;
    Map<CharacterPart, BitmapData> previewBitmapImages = animation.getPreview();

    CharacterPreview currentPreview = _characterPreviews[gameCharacter];
    if (currentPreview == null) {
      currentPreview = new CharacterPreview();
      _characterPreviews[gameCharacter] = currentPreview;
    }
    currentPreview.updateAndPopulatePreview(this.parent, previewBitmapImages);
  }

  void _renderGameCharacterPreview(GameCharacter gameCharacter, int index) {
    CharacterPreview preview = _characterPreviews[gameCharacter];

    Bitmap bodyBitmap = preview.bitmaps[CharacterPart.BODY];
    num left = 5 +
        index * bodyBitmap.bitmapData.width +
        bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.left;
    num top = _screen.height -
        5 -
        bodyBitmap.bitmapData.height +
        bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.top;
    for (Bitmap previewBitmap in preview.bitmaps.values) {
      previewBitmap.x = left;
      previewBitmap.y = top;
    }
  }
}
