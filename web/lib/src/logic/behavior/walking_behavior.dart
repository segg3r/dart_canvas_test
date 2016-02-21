part of survive_game.logic;

class WalkingBehavior implements Behavior {

  static final RANDOM = new Math.Random();

  Trigger _trigger;

  WalkingBehavior(double period) {
    this._trigger = new Trigger.withPeriod(period);
  }

  @override
  void advanceTime(num time, GameCharacter gameCharacter) {
    for (int i = 0; i < _trigger.advanceTime(time); i++) {
      int x = RANDOM.nextInt(800);
      int y = RANDOM.nextInt(600);
      gameCharacter.destination = new Math.Point(x, y);
    }
  }
}
