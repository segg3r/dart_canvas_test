part of survive_game.graphics;

class TransparencyImageDataFilter implements ImageDataFilter {

  static final RGBAColor TRANSPARENT_WHITE = new RGBAColor.fromRGBA(0, 0, 0, 0);

  static final int CELLS_BY_PIXEL = 4;
  static final int RED_INDEX = 0;
  static final int GREEN_INDEX = 1;
  static final int BLUE_INDEX = 2;
  static final int ALPHA_INDEX = 3;

  RGBAColor _color;
  RGBAColor _exchangeColor;

  TransparencyImageDataFilter.intoColor(this._color, this._exchangeColor);

  TransparencyImageDataFilter.intoTransparentWhite(this._color) {
    _exchangeColor = TRANSPARENT_WHITE;
  }

  @override
  ImageData filter(ImageData imageData) {
    List<int> data = imageData.data;

    for (int i = 0; i < data.length / CELLS_BY_PIXEL; i++) {
      RGBAColor dataColor = _getColorFromData(data, i);
      if (_color == dataColor) {
        _setColorIntoData(data, i, _exchangeColor);
      }
    }

    return imageData;
  }

  RGBAColor _getColorFromData(List<int> data, int index) {
    int red = data[index * CELLS_BY_PIXEL + RED_INDEX];
    int green = data[index * CELLS_BY_PIXEL + GREEN_INDEX];
    int blue = data[index * CELLS_BY_PIXEL + BLUE_INDEX];
    int alpha = data[index * CELLS_BY_PIXEL + ALPHA_INDEX];

    return new RGBAColor.fromRGBA(red, green, blue, alpha);
  }

  void _setColorIntoData(List<int> data, int index, RGBAColor dataColor) {
    data[index * CELLS_BY_PIXEL + RED_INDEX] = dataColor.red;
    data[index * CELLS_BY_PIXEL + GREEN_INDEX] = dataColor.green;
    data[index * CELLS_BY_PIXEL + BLUE_INDEX] = dataColor.blue;
    data[index * CELLS_BY_PIXEL + ALPHA_INDEX] = dataColor.alpha;
  }

}
