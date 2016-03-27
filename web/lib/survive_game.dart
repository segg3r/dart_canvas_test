library survive_game;

import 'package:stagexl/stagexl.dart';
import 'dart:html' as Dom;
import 'dart:async';
import 'dart:math' as Math;

import 'src/resources.dart';
import 'src/graphics.dart';
import 'src/logic.dart';
import 'src/ui.dart';

class SurviveGameStage extends Stage {
  static final String CHARACTER_IMAGES_DIRECTORY = 'resources/image/character';

  Screen _screen;

  SurviveGameStage(Dom.CanvasElement canvas) : super(canvas) {
    this._screen = new Screen.ofSize(canvas.width, canvas.height);
  }

  init() async {
    CharacterBitmapResourceManager characterPartResourceManager =
        await _initializeCharacterResourceManager();
    Map<CharacterPart, CharacterFlipBook> characterFlipBooks = {
      CharacterPart.BODY: characterPartResourceManager
          .buildCharacterFlipBook(CharacterBitmapDescriptor.WHITE_BODY),
      CharacterPart.ARMOR: characterPartResourceManager
          .buildCharacterFlipBook(CharacterBitmapDescriptor.PURPLE_CLOTH),
      CharacterPart.FACE: characterPartResourceManager.buildCharacterFlipBook(
          CharacterBitmapDescriptor.WHITE_FACE_BLUE_EYES),
      CharacterPart.HAIR: characterPartResourceManager
          .buildCharacterFlipBook(CharacterBitmapDescriptor.RED_HAIR)
    };
    CharacterAnimation animation = new CharacterAnimation(characterFlipBooks);

    Math.Point position = new Math.Point(400, 300);
    GameCharacter gameCharacter = new GameCharacter.withAnimation(animation)
          ..position = position
          ..destination = position;
    CharacterSelector characterSelector =
        new CharacterSelector.withCharacters(_screen, [gameCharacter]);

    this.addChild(gameCharacter);
    this.addChild(characterSelector);
    this.juggler.add(gameCharacter);
    this.focus = this;

    this.onKeyDown.listen((keyboardEvent) {
      characterSelector.handleKeyboardEvent(keyboardEvent);
    });
  }

  Future<CharacterBitmapResourceManager>
      _initializeCharacterResourceManager() async {
    CharacterBitmapResourceManager resourceManager =
        new CharacterBitmapResourceManager(CHARACTER_IMAGES_DIRECTORY);
    List<CharacterBitmapDescriptor> allCharacterBitmaps =
        CharacterBitmapDescriptor.VALUES;
    resourceManager.initialize(allCharacterBitmaps);
    await resourceManager.load();

    return resourceManager;
  }
}
