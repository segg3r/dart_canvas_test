part of survive_game.graphics;

class CharacterPreview {
  Map<CharacterPart, Bitmap> _bitmaps = new Map<CharacterPart, Bitmap>();

  CharacterPreview();

  void updateAndPopulatePreview(DisplayObjectParent parent,
      Map<CharacterPart, BitmapData> previewBitmapImages) {
    for (CharacterPart characterPart in CharacterPart.inRenderingOrder()) {
      _verifyCharacterPart(
          parent, characterPart, previewBitmapImages[characterPart]);
    }
  }

  void _verifyCharacterPart(DisplayObjectParent parent,
      CharacterPart characterPart, BitmapData bitmapData) {
    Bitmap bitmap = _bitmaps[characterPart];
    if (bitmap == null) {
      bitmap = new Bitmap(bitmapData);
      _bitmaps[characterPart] = bitmap;
      parent.addChild(bitmap);
    } else if (bitmap.bitmapData != bitmapData) {
      bitmap.bitmapData = bitmapData;
    }
  }

  get bitmaps => _bitmaps;

}
