part of survive_game.logic;

class Trigger {
  double _period;
  double _passed = 0.0;

  Trigger.withPeriod(this._period);

  int advanceTime(num time) {
    int triggeredTimes = 0;
    _passed += time;
    while (_passed >= _period) {
      _passed -= _period;
      triggeredTimes++;
    }
    return triggeredTimes;
  }
}
