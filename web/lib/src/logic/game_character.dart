part of survive_game.logic;

class GameCharacter extends DisplayObject implements Animatable {

  static final double DEFAULT_MOVEMENT_SPEED = 150.0;

  CharacterFlipBook _flipBook;
  Math.Point _destination;
  double _direction;
  double _speed = 0.0;
  double _movementSpeed = DEFAULT_MOVEMENT_SPEED;

  GameCharacter.withFlipBook(this._flipBook);

  @override
  bool advanceTime(num time) {
    _processMovement(time);
    _updateFlipBook(time);
    return true;
  }

  void _processMovement(num time) {
    Math.Point currentPoint = _getCurrentPoint();
    double distanceToDestination = currentPoint.distanceTo(_destination);
    if (distanceToDestination > _speed * time) {
      if (_speed == 0) {
        _speed = _movementSpeed;
      }
      double directionToDestination = Direction.betweenPoints(currentPoint, _destination);
      _setDirection(directionToDestination);
    } else {
      position = new Math.Point(_destination.x, _destination.y);
      _speed = 0.0;
    }

    double finalX = this.x + time * _speed * Math.cos(_direction);
    double finalY = this.y + time * _speed * Math.cos(_direction);
    position = new Math.Point(finalX, finalY);
  }

  void _updateFlipBook(num time) {
    if (_speed > 0) {
      _flipBook.play(_speed);
    } else {
      _flipBook.stop();
    }
    _flipBook.advanceTime(time);
  }

  @override
  void render(RenderState renderState) {
    _flipBook.render(renderState);
  }

  set destination(Math.Point destination) {
    this._destination = destination;
  }

  Math.Point _getCurrentPoint() {
    return new Math.Point(this.x, this.y);
  }

  void _setDirection(double direction) {
    this._direction = direction;
    _flipBook.direction = Direction.fromDirection(direction);
  }

  set position(Math.Point position) {
    this.x = position.x;
    this.y = position.y;
    _flipBook.x = position.x;
    _flipBook.y = position.y;
  }

}