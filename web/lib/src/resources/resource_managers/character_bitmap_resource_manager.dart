part of survive_game.resources;

class CharacterBitmapResourceManager extends FilteringResourceManager {

  static RGBAColor BACKGROUND_GREEN = new RGBAColor.fromRGB(32, 156, 0);
  static TransparencyImageDataFilter CHARACTER_BITMAP_BACKGROUND_FILTER =
    new TransparencyImageDataFilter.intoTransparentWhite(BACKGROUND_GREEN);
  static List<ImageDataFilter> DEFAULT_FILTERS =
    [ CHARACTER_BITMAP_BACKGROUND_FILTER ];

  PathResolver _pathResolver;
  Map<String, List<BitmapData>> _characterBitmapsCache = new Map<String,
      List<BitmapData>>();

  CharacterBitmapResourceManager(this._pathResolver) : super(DEFAULT_FILTERS);

  void addCharacterBitmapData(String name) {
    String url = _pathResolver.resolvePath(name);
    super.addBitmapData(name, url);
  }

  List<BitmapData> getCharacterBitmaps(String name) {

    List<BitmapData> result = _getCachedBitmaps(name);
    if (result == null) {
      List<BitmapData> characterBitmaps = _buildCharacterBitmaps(name);
      result = _buildOffsetBitmaps(characterBitmaps);
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

  List<BitmapData> _buildOffsetBitmaps(List<BitmapData> characterBitmaps) {
    List<BitmapData> result = new List<BitmapData>();

    for (BitmapData characterBitmap in characterBitmaps) {
      BitmapData offsetBitmap = _buildOffsetBitmap(characterBitmap);
      result.add(offsetBitmap);
    }

    return result;
  }

  BitmapData _buildOffsetBitmap(BitmapData characterBitmap) {
    int offsetX = (characterBitmap.width / 2).round();
    int offsetY = characterBitmap.height;
    Math.Point offset = new Math.Point(offsetX, offsetY);
    return BitmapUtil.withOffset(characterBitmap, offset);
  }

  List<BitmapData> _splitInFrames(BitmapData bitmapData) {
    int width = bitmapData.width;
    int height = bitmapData.height;

    int frameWidth = (width / CharacterFlipBook.IMAGE_HORIZONTAL_FRAMES)
        .round();
    int frameHeight = (height / CharacterFlipBook.IMAGE_VERTICAL_FRAMES)
        .round();

    return bitmapData
        .sliceIntoFrames(frameWidth, frameHeight);
  }

  void _cacheBitmaps(String name, List<BitmapData> result) {
    _characterBitmapsCache[name] = result;
  }

}
