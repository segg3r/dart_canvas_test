part of survive_game.graphics;

class CharacterFlipBook extends DisplayObject implements Animatable {

  static final Map<Direction, int> SPRITE_ROWS = {
    Direction.UP : 0,
    Direction.DOWN : 2,
    Direction.LEFT : 3,
    Direction.RIGHT : 1
  };

  static final int IMAGE_HORIZONTAL_FRAMES = 3;
  static final int TOTAL_HORIZONTAL_FRAMES = 4;
  static final int IMAGE_VERTICAL_FRAMES = 4;
  static final int TOTAL_VERTICAL_FRAMES = IMAGE_VERTICAL_FRAMES;
  static final int STANDING_FRAME_INDEX = 1;

  static final double SPEED_FRAME_RATE = 0.09;

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

  void play(double speed) {
    FlipBook currentFlipBook = _getCurrentFlipBook();
    _populateFrameRate(currentFlipBook, speed);
    if (!currentFlipBook.playing) {
      currentFlipBook.play();
    }
  }

  void _populateFrameRate(FlipBook currentFlipBook, double speed) {
    currentFlipBook.frameDurations = new List.filled(TOTAL_HORIZONTAL_FRAMES,
        1.0 / speed / SPEED_FRAME_RATE);
  }

  void stop() {
    FlipBook currentFlipBook = _getCurrentFlipBook();
    currentFlipBook.gotoAndStop(STANDING_FRAME_INDEX);
  }

  FlipBook _getCurrentFlipBook() {
    return _flipBooks[_direction];
  }

  Map<Direction, FlipBook> _populateDirectionFlipBooks(
      List<BitmapData> bitmaps) {
    Map<Direction, FlipBook> directionFlipBooks = new Map<Direction, FlipBook>();

    for (Direction direction in Direction.VALUES) {
      int rowIndex = SPRITE_ROWS[direction];

      int from = rowIndex * IMAGE_HORIZONTAL_FRAMES;
      int to = from + IMAGE_HORIZONTAL_FRAMES;
      int middleFrameIndex = from + STANDING_FRAME_INDEX;

      List<BitmapData> flipBookBitmaps = bitmaps.sublist(from, to);
      flipBookBitmaps.add(bitmaps[middleFrameIndex]);

      FlipBook flipBook = new FlipBook(flipBookBitmaps);
      flipBook.gotoAndStop(STANDING_FRAME_INDEX);
      directionFlipBooks[direction] = flipBook;
    }

    return directionFlipBooks;
  }

  set direction(Direction direction) => this._direction = direction;

}