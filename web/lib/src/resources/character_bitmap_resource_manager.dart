part of survive_game.resources;

class CharacterBitmapResourceManager extends FilteringResourceManager {

  static RGBAColor BACKGROUND_GREEN = new RGBAColor.fromRGB(32, 156, 0);
  static TransparencyImageDataFilter CHARACTER_BITMAP_BACKGROUND_FILTER = new TransparencyImageDataFilter
      .intoTransparentWhite(BACKGROUND_GREEN);
  static List<ImageDataFilter> DEFAULT_FILTERS = [
    CHARACTER_BITMAP_BACKGROUND_FILTER];

  Map<String, List<BitmapData>> _characterBitmapsCache = new Map<String,
      List<BitmapData>>();

  CharacterBitmapResourceManager() : super(DEFAULT_FILTERS);

  List<BitmapData> getCharacterBitmaps(String name) {
    List<BitmapData> result = _getCachedBitmaps(name);

    if (result == null) {
      result = _buildCharacterBitmaps(name);
      _cacheBitmaps(name, result);
    }

    return result;
  }

  List<BitmapData> _getCachedBitmaps(String name) {
    return _characterBitmapsCache[name];
  }

  List<BitmapData> _buildCharacterBitmaps(String name) {
    BitmapData basicBitmapData = getBitmapData(name);
    return _splitInFrames(basicBitmapData);
  }

  List<BitmapData> _splitInFrames(BitmapData bitmapData) {
    int width = bitmapData.width;
    int height = bitmapData.height;

    int frameWidth = (width / CharacterFlipBook.IMAGE_HORIZONTAL_FRAMES).round();
    int frameHeight = (height / CharacterFlipBook.IMAGE_VERTICAL_FRAMES).round();

    return bitmapData
        .sliceIntoFrames(frameWidth, frameHeight);
  }

  void _cacheBitmaps(String name, List<BitmapData> result) {
    _characterBitmapsCache[name] = result;
  }

}