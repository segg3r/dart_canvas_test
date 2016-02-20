library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math' as Math;

import 'src/resources.dart';
import 'src/graphics.dart';
import 'src/logic.dart';

class SurviveGameStage extends Stage {

  SurviveGameStage(CanvasElement canvas) : super(canvas);

  init() async {
    CharacterBitmapResourceManager characterBitmapResourceManager = await _initializeCharacterBitmapResourceManager();

    List<BitmapData> bodyBitmaps = characterBitmapResourceManager
        .getCharacterBitmaps('body001');
    CharacterFlipBook characterFlipBook = new CharacterFlipBook.fromBitmaps(
        bodyBitmaps);

    GameCharacter gameCharacter = new GameCharacter.withFlipBook(characterFlipBook);
    gameCharacter.position = new Math.Point(400, 400);
    gameCharacter.destination = new Math.Point(100, 100);
    this.addChild(gameCharacter);
    this.juggler.add(gameCharacter);
  }

  Future<CharacterBitmapResourceManager> _initializeCharacterBitmapResourceManager() async {
    CharacterBitmapResourceManager resourceManager = new CharacterBitmapResourceManager()
      ..addBitmapData('body001', 'resources/image/character/body/001.png');

    return await resourceManager.load();
  }

}