part of survive_game.common;

class Direction {

  static final Direction UP = new Direction();
  static final Direction DOWN = new Direction();
  static final Direction LEFT = new Direction();
  static final Direction RIGHT = new Direction();

  static final List<Direction> VALUES = [ UP, DOWN, LEFT, RIGHT ];

  static Direction fromDirection(double direction) {
    if (direction >= Math.PI / 4.0 && direction < Math.PI * 3.0 / 4.0) {
      return UP;
    } else if (direction >= Math.PI * 3.0 / 4.0 && direction < Math.PI * 5.0 / 4.0) {
      return LEFT;
    } else if (direction >= Math.PI * 5.0 / 4.0 && direction < Math.PI * 7.0 / 4.0) {
      return DOWN;
    } else {
      return RIGHT;
    }
  }

  static double betweenPoints(Math.Point from, Math.Point to) {
    double atan = Math.atan2(to.y - from.y, to.x - from.x);
    if (atan > 0) {
      return Math.PI * 2 - atan;
    } else if (atan < 0) {
      return -atan;
    } else {
      return 0.0;
    }
  }

}