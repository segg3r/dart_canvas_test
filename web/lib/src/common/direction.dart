part of survive_game.common;

class Direction {

  static final Direction UP = new Direction();
  static final Direction DOWN = new Direction();
  static final Direction LEFT = new Direction();
  static final Direction RIGHT = new Direction();

  static final List<Direction> VALUES = [ UP, DOWN, LEFT, RIGHT ];

  static Direction fromDirection(double direction) {
    if (direction >= PI / 4.0 && direction < PI * 3.0 / 4.0) {
      return UP;
    } else if (direction >= PI * 3.0 / 4.0 && direction < PI * 5.0 / 4.0) {
      return LEFT;
    } else if (direction >= PI * 5.0 / 4.0 && direction < PI * 7.0 / 4.0) {
      return DOWN;
    } else {
      return RIGHT;
    }
  }

}