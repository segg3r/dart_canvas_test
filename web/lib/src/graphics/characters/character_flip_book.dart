part of survive_game.graphics;

class CharacterFlipBook extends DisplayObject implements Animatable {

  static final Map<Direction, int> SPRITE_ROWS = {
    Direction.UP : 0,
    Direction.DOWN : 2,
    Direction.LEFT : 3,
    Direction.RIGHT : 1
  };

  static final int HORIZONTAL_FRAMES = 3;
  static final int VERTICAL_FRAMES = 4;
  static final int STANDING_FRAME_INDEX = 1;

  Map<Direction, FlipBook> _flipBooks;
  Direction _direction;

  CharacterFlipBook.fromBitmaps(List<BitmapData> bitmaps) {
    _flipBooks = _populateDirectionFlipBooks(bitmaps);
    _direction = Direction.DOWN;
  }

  @override
  bool advanceTime(num time) {
    FlipBook currentFlipBook = _getCurrentFlipBook();
    return currentFlipBook.advanceTime(time);
  }

  @override
  void render(RenderState renderState) {
    FlipBook currentFlipBook = _getCurrentFlipBook();
    currentFlipBook.render(renderState);
  }

  FlipBook _getCurrentFlipBook() {
    return _flipBooks[_direction];
  }

  Map<Direction, FlipBook> _populateDirectionFlipBooks(
      List<BitmapData> bitmapDatas) {
    Map<Direction, FlipBook> directionFlipBooks = new Map<Direction, FlipBook>();

    for (Direction direction in Direction.VALUES) {
      int rowIndex = SPRITE_ROWS[direction];

      int from = rowIndex * HORIZONTAL_FRAMES;
      int to = from + HORIZONTAL_FRAMES;
      int middleFrameIndex = from + STANDING_FRAME_INDEX;

      List<BitmapData> flipBookBitmapDatas = bitmapDatas.sublist(from, to);
      flipBookBitmapDatas.add(bitmapDatas[middleFrameIndex]);

      FlipBook flipBook = new FlipBook(flipBookBitmapDatas);
      flipBook.gotoAndStop(STANDING_FRAME_INDEX);
      directionFlipBooks[direction] = flipBook;
    }

    return directionFlipBooks;
  }

}