library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html';
import 'dart:async';

import 'src/resources.dart';
import 'src/graphics.dart';

class SurviveGameStage extends Stage {

  SurviveGameStage(CanvasElement canvas) : super(canvas);

  init() async {
    CharacterBitmapResourceManager characterBitmapResourceManager = await _initializeCharacterBitmapResourceManager();

    List<BitmapData> bodyBitmaps = characterBitmapResourceManager
        .getCharacterBitmaps('body001');
    CharacterFlipBook characterFlipBook = new CharacterFlipBook.fromBitmaps(
        bodyBitmaps);
    characterFlipBook.x = 25;
    characterFlipBook.y = 25;
    this.addChild(characterFlipBook);
    this.juggler.add(characterFlipBook);
  }

  Future<CharacterBitmapResourceManager> _initializeCharacterBitmapResourceManager() async {
    CharacterBitmapResourceManager resourceManager = new CharacterBitmapResourceManager()
      ..addBitmapData('body001', 'resources/image/character/body/001.png');

    return await resourceManager.load();
  }

}