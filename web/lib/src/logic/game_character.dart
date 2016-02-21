part of survive_game.logic;

class GameCharacter extends DisplayObject implements Animatable {

  static final double DEFAULT_MOVEMENT_SPEED = 150.0;

  CharacterAnimation _animation;
  Math.Point _destination;
  double _direction;
  double _speed = 0.0;
  double _movementSpeed = DEFAULT_MOVEMENT_SPEED;

  GameCharacter.withAnimation(this._animation);

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
      _animation.play(_speed);
    } else {
      _animation.stop();
    }
    _animation.advanceTime(time);
  }

  @override
  void render(RenderState renderState) {
    _animation.render(renderState);
  }

  set destination(Math.Point destination) {
    this._destination = destination;
  }

  Math.Point _getCurrentPoint() {
    return new Math.Point(this.x, this.y);
  }

  void _setDirection(double direction) {
    this._direction = direction;
    _animation.direction = Direction.fromDirection(direction);
  }

  set position(Math.Point position) {
    this.x = position.x;
    this.y = position.y;
    _animation.x = position.x;
    _animation.y = position.y;
  }

}
