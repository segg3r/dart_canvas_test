library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math' as Math;

import 'src/resources.dart';
import 'src/graphics.dart';
import 'src/logic.dart';

class SurviveGameStage extends Stage {
  static final CHARACTER_SET_NAME = '001';

  SurviveGameStage(CanvasElement canvas) : super(canvas);

  init() async {
    CharacterBitmapResourceManager characterBitmapResourceManager =
        await _initializeCharacterBitmapResourceManager();

    List<BitmapData> bodyBitmaps =
        characterBitmapResourceManager.getCharacterBitmaps(CHARACTER_SET_NAME);
    CharacterFlipBook characterFlipBook =
        new CharacterFlipBook.fromBitmaps(bodyBitmaps);

    GameCharacter gameCharacter =
        new GameCharacter.withFlipBook(characterFlipBook);
    gameCharacter.position = new Math.Point(400, 400);
    gameCharacter.destination = new Math.Point(100, 100);
    this.addChild(gameCharacter);
    this.juggler.add(gameCharacter);
  }

  Future<CharacterBitmapResourceManager>
      _initializeCharacterBitmapResourceManager() async {
    PathResolver bodyBitmapsPathResolver =
        new DirectoryPathResolver.ofDirectory(
            'resources/image/character/body', 'png');
    CharacterBitmapResourceManager resourceManager =
        new CharacterBitmapResourceManager(bodyBitmapsPathResolver)
          ..addCharacterBitmapData(CHARACTER_SET_NAME);

    return await resourceManager.load();
  }
}
