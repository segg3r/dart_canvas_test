part of survive_game.ui;

class CharacterSelector extends DisplayObject {
  static final int CHARACTER_SELECTOR_LEFT_OFFSET = 5;
  static final int CHARACTER_SELECTOR_BOTTOM_OFFSET = 5;

  static final int CHARACTER_INDEX_PREVIEW_LEFT_OFFSET = 5;
  static final int CHARACTER_INDEX_PREVIEW_TOP_OFFSET = 5;

  static final TextFormat UNSELECTED_CHARACTER_TEXT_FORMAT = new TextFormat(
      'Tahoma', 12, Color.White,
      bold: true, strokeColor: Color.Black, strokeWidth: 2);
  static final TextFormat SELECTED_CHARACTER_TEXT_FORMAT = new TextFormat(
      'Tahoma', 12, Color.Orange,
      bold: true, strokeColor: Color.Black, strokeWidth: 2);

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
    Bitmap bodyBitmap = previewBitmaps[CharacterPart.BODY];
    num left =
        CHARACTER_SELECTOR_LEFT_OFFSET + index * bodyBitmap.bitmapData.width;
    num top = _screen.height -
        CHARACTER_SELECTOR_BOTTOM_OFFSET -
        bodyBitmap.bitmapData.height;
    _renderPreviewBitmaps(
        renderState,
        previewBitmaps,
        left + bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.left,
        top + bodyBitmap.bitmapData.renderTextureQuad.offsetRectangle.top);
    _renderIndexText(renderState, index, left, top);
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
      Map<CharacterPart, Bitmap> previewBitmaps, num left, num top) {
    for (CharacterPart characterPart in CharacterPart.inRenderingOrder()) {
      Bitmap previewBitmap = previewBitmaps[characterPart];
      previewBitmap.x = left;
      previewBitmap.y = top;
      renderState.renderObject(previewBitmap);
    }
  }

  void _renderIndexText(RenderState renderState, int index, num left, num top) {
    String indexText = (index + 1).toString();

    TextField textField = new TextField();
    textField.defaultTextFormat = UNSELECTED_CHARACTER_TEXT_FORMAT;
    textField.text = indexText;
    textField.x = left + CHARACTER_INDEX_PREVIEW_LEFT_OFFSET;
    textField.y = top + CHARACTER_INDEX_PREVIEW_TOP_OFFSET;
    renderState.renderObject(textField);
  }
}
