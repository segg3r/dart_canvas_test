part of survive_game.graphics;

class CharacterPart {

  static final CharacterPart BODY = new CharacterPart('body');
  static final CharacterPart FACE = new CharacterPart('face');
  static final CharacterPart HAIR = new CharacterPart('hair');
  static final CharacterPart ARMOR = new CharacterPart('armor');

  static final List<CharacterPart> VALUES = [ BODY, FACE, HAIR, ARMOR ];

  static List<CharacterPart> inRenderingOrder() {
    return [ BODY, FACE, HAIR, ARMOR ];
  }

  String _directory;

  CharacterPart(this._directory);

  get directory => this._directory;

}
