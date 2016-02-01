part of survive_game.graphics;

class RGBAColor {

  int _red;
  int _green;
  int _blue;
  int _alpha;

  RGBAColor.fromRGBA(this._red, this._green, this._blue, this._alpha);

  RGBAColor.fromRGB(this._red, this._green, this._blue) {
    _alpha = 255;
  }

  int get red => _red;

  int get alpha => _alpha;

  int get blue => _blue;

  int get green => _green;

  bool operator ==(other) {
    return other is RGBAColor
        && other._red == _red
        && other._green == _green
        && other._blue == _blue
        && other._alpha == _alpha;
  }

  int get hashCode {
    return 31 * _red
        + 23 * _green
        + 17 * _blue
        + 13 * _alpha;
  }


}