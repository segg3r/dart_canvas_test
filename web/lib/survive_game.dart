library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html';
import 'dart:async';

import 'src/resources.dart';
import 'src/graphics.dart';

class SurviveGameStage extends Stage {

  SurviveGameStage(CanvasElement canvas) : super(canvas);

  init() async {
    ResourceManager characterSpriteResourceManager = await _initializeCharacterSpriteResourceManager();

    BitmapData bodyData = characterSpriteResourceManager.getBitmapData(
        'body001');
    Bitmap body = new Bitmap(bodyData);
    body.x = 25;
    body.y = 25;
    stage.addChild(body);
  }

  Future<ResourceManager> _initializeCharacterSpriteResourceManager() async {
    RGBAColor green = new RGBAColor.fromRGB(32, 156, 0);
    TransparencyImageDataFilter transparencyFilter = new TransparencyImageDataFilter
        .intoTransparentWhite(green);

    FilteringResourceManager resourceManager = new FilteringResourceManager(
        [transparencyFilter])
      ..addBitmapData('body001', 'resources/image/character/body/001.png');

    return await resourceManager.load();
  }

}