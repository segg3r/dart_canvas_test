part of survive_game.resources;

class CharacterBitmapResourceManager extends FilteringResourceManager {
  static final String CHARACTER_BITMAP_EXTENSION = 'png';
  static final RGBAColor BACKGROUND_GREEN = new RGBAColor.fromRGB(32, 156, 0);
  static final TransparencyImageDataFilter CHARACTER_BITMAP_BACKGROUND_FILTER =
      new TransparencyImageDataFilter.intoTransparentWhite(BACKGROUND_GREEN);
  static final List<ImageDataFilter> DEFAULT_FILTERS = [
    CHARACTER_BITMAP_BACKGROUND_FILTER
  ];

  String _bitmapsDirectory;
  Map<CharacterPart, PathResolver> _characterPartResolversCache =
      new Map<CharacterPart, PathResolver>();
  Map<CharacterBitmapDescriptor, List<BitmapData>> _characterBitmapsCache =
      new Map<CharacterBitmapDescriptor, List<BitmapData>>();

  CharacterBitmapResourceManager(this._bitmapsDirectory)
      : super(DEFAULT_FILTERS);

  void initialize(List<CharacterBitmapDescriptor> bitmapDescriptors) {
    for (CharacterBitmapDescriptor bitmapDescriptor in bitmapDescriptors) {
      PathResolver characterPartResolver =
          _getCharacterPartResolver(bitmapDescriptor.characterPart);
      String url = characterPartResolver.resolvePath(bitmapDescriptor.fileName);
      String internalBitmapName = _buildInternalBitmapName(bitmapDescriptor);
      super.addBitmapData(internalBitmapName, url);
    }
  }

  PathResolver _getCharacterPartResolver(CharacterPart characterPart) {
    PathResolver result = _getCachedCharacterPartResolver(characterPart);
    if (result == null) {
      result = new DirectoryPathResolver.ofDirectory(
          _bitmapsDirectory + '/' + characterPart.directory,
          CHARACTER_BITMAP_EXTENSION);
      _cacheCharacterPartResolver(characterPart, result);
    }
    return result;
  }

  PathResolver _getCachedCharacterPartResolver(CharacterPart characterPart) {
    return _characterPartResolversCache[characterPart];
  }

  void _cacheCharacterPartResolver(
      CharacterPart characterPart, PathResolver pathResolver) {
    _characterPartResolversCache[characterPart] = pathResolver;
  }

  CharacterFlipBook buildCharacterFlipBook(
      CharacterBitmapDescriptor bitmapDescriptor) {
    List<BitmapData> bitmaps = _getCharacterBitmaps(bitmapDescriptor);
    return new CharacterFlipBook.fromBitmaps(bitmaps);
  }

  List<BitmapData> _getCharacterBitmaps(
      CharacterBitmapDescriptor bitmapDescriptor) {
    List<BitmapData> result = _getCachedBitmaps(bitmapDescriptor);
    if (result == null) {
      List<BitmapData> characterBitmaps =
          _buildCharacterBitmaps(bitmapDescriptor);
      result = _buildOffsetBitmaps(characterBitmaps);
      _cacheBitmaps(bitmapDescriptor, result);
    }

    return result;
  }

  List<BitmapData> _getCachedBitmaps(
      CharacterBitmapDescriptor bitmapDescriptor) {
    return _characterBitmapsCache[bitmapDescriptor];
  }

  List<BitmapData> _buildCharacterBitmaps(
      CharacterBitmapDescriptor bitmapDescriptor) {
    String internalName = _buildInternalBitmapName(bitmapDescriptor);
    BitmapData basicBitmapData = getBitmapData(internalName);
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

    int frameWidth =
        (width / CharacterFlipBook.IMAGE_HORIZONTAL_FRAMES).round();
    int frameHeight =
        (height / CharacterFlipBook.IMAGE_VERTICAL_FRAMES).round();

    return bitmapData.sliceIntoFrames(frameWidth, frameHeight);
  }

  void _cacheBitmaps(
      CharacterBitmapDescriptor bitmapDescriptor, List<BitmapData> result) {
    _characterBitmapsCache[bitmapDescriptor] = result;
  }

  String _buildInternalBitmapName(CharacterBitmapDescriptor bitmapDescriptor) {
    return bitmapDescriptor.characterPart.directory +
        ':' +
        bitmapDescriptor.fileName;
  }
}
