import 'dart:html';

import 'package:stagexl/stagexl.dart';
import 'lib/survive_game.dart';

main() async {
  CanvasElement canvas = querySelector('#stage');
  SurviveGameStage stage = new SurviveGameStage(canvas);
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  stage.init();
}
