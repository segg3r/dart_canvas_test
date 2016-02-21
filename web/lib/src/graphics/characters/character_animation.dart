part of survive_game.graphics;

class CharacterAnimation extends DisplayObject implements Animatable {
  Map<CharacterPart, CharacterFlipBook> _flipBooks;

  CharacterAnimation(this._flipBooks);

  @override
  bool advanceTime(num time) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.advanceTime(time);
    }
    return true;
  }

  @override
  void render(RenderState renderState) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.render(renderState);
    }
  }

  void play(double speed) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.play(speed);
    }
  }

  void stop() {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.stop();
    }
  }

  set direction(Direction direction) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.direction = direction;
    }
  }

  set x(double x) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.x = x;
    }
  }

  set y(double y) {
    for (CharacterFlipBook flipBook in _getActiveFlipBooksInRenderingOrder()) {
      flipBook.y = y;
    }
  }

  List<CharacterFlipBook> _getActiveFlipBooksInRenderingOrder() {
    List<CharacterFlipBook> result = new List<CharacterFlipBook>();
    for (CharacterPart characterPart in CharacterPart.inRenderingOrder()) {
      CharacterFlipBook characterFlipBook = _flipBooks[characterPart];
      if (characterFlipBook != null) {
        result.add(characterFlipBook);
      }
    }
    return result;
  }

}
