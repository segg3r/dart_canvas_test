library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math' as Math;

import 'src/resources.dart';
import 'src/graphics.dart';
import 'src/logic.dart';

class SurviveGameStage extends Stage {
  static final String CHARACTER_IMAGES_DIRECTORY = 'resources/image/character';

  SurviveGameStage(CanvasElement canvas) : super(canvas);

  init() async {
    CharacterBitmapResourceManager characterPartResourceManager =
        await _initializeCharacterResourceManager();
    Map<CharacterPart, CharacterFlipBook> characterFlipBooks = {
      CharacterPart.BODY : characterPartResourceManager.buildCharacterFlipBook(CharacterBitmapDescriptor.WHITE_BODY),
      CharacterPart.ARMOR : characterPartResourceManager.buildCharacterFlipBook(CharacterBitmapDescriptor.PURPLE_CLOTH),
      CharacterPart.FACE : characterPartResourceManager.buildCharacterFlipBook(CharacterBitmapDescriptor.WHITE_FACE_BLUE_EYES),
      CharacterPart.HAIR : characterPartResourceManager.buildCharacterFlipBook(CharacterBitmapDescriptor.RED_HAIR)
    };
    CharacterAnimation animation = new CharacterAnimation(characterFlipBooks);

    GameCharacter gameCharacter =
        new GameCharacter.withAnimation(animation);
    gameCharacter.position = new Math.Point(400, 400);
    gameCharacter.destination = new Math.Point(100, 100);
    this.addChild(gameCharacter);
    this.juggler.add(gameCharacter);
  }

  Future<CharacterBitmapResourceManager>
      _initializeCharacterResourceManager() async {
    CharacterBitmapResourceManager resourceManager = new CharacterBitmapResourceManager(CHARACTER_IMAGES_DIRECTORY);
    List<CharacterBitmapDescriptor> allCharacterBitmaps = CharacterBitmapDescriptor.VALUES;
    resourceManager.initialize(allCharacterBitmaps);
    await resourceManager.load();

    return resourceManager;
  }

}
