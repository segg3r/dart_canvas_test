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
    Map<CharacterPart, CharacterBitmapResourceManager>
        characterPartsResourceManagers =
        await _initializeCharacterPartsResourceManagers();
    Map<CharacterPart, CharacterFlipBook> characterFlipBooks =
        _getCharacterFlipBooks(
            characterPartsResourceManagers, CHARACTER_SET_NAME);
    CharacterAnimation animation = new CharacterAnimation(characterFlipBooks);

    GameCharacter gameCharacter =
        new GameCharacter.withAnimation(animation);
    gameCharacter.position = new Math.Point(400, 400);
    gameCharacter.destination = new Math.Point(100, 100);
    this.addChild(gameCharacter);
    this.juggler.add(gameCharacter);
  }

  Future<Map<CharacterPart, CharacterBitmapResourceManager>>
      _initializeCharacterPartsResourceManagers() async {
    Map<CharacterPart, CharacterBitmapResourceManager> resourceManagers =
        new Map<CharacterPart, CharacterBitmapResourceManager>();

    for (CharacterPart characterPart in CharacterPart.VALUES) {
      PathResolver characterPartPathResolver =
          new DirectoryPathResolver.ofDirectory(
              'resources/image/character/' + characterPart.directory, 'png');
      CharacterBitmapResourceManager characterPartResourceManager =
          new CharacterBitmapResourceManager(characterPartPathResolver);
      characterPartResourceManager.addCharacterBitmapData(CHARACTER_SET_NAME);
      resourceManagers[characterPart] = characterPartResourceManager;
      await characterPartResourceManager.load();
    }

    return resourceManagers;
  }

  Map<CharacterPart, CharacterFlipBook> _getCharacterFlipBooks(
      Map<CharacterPart,
          CharacterBitmapResourceManager> characterPartsResourceManagers,
      String characterSetName) {
    Map<CharacterPart, CharacterFlipBook> result =
        new Map<CharacterPart, CharacterFlipBook>();
    for (CharacterPart characterPart in CharacterPart.VALUES) {
      CharacterBitmapResourceManager resourceManager =
          characterPartsResourceManagers[characterPart];
      List<BitmapData> characterPartBitmaps =
          resourceManager.getCharacterBitmaps(characterSetName);
      CharacterFlipBook characterPartFlipBook =
          new CharacterFlipBook.fromBitmaps(characterPartBitmaps);
      result[characterPart] = characterPartFlipBook;
    }
    return result;
  }
}
