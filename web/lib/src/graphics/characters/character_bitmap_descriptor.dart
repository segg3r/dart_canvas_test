part of survive_game.graphics;

class CharacterBitmapDescriptor {
  // armors
  static final CharacterBitmapDescriptor PURPLE_CLOTH =
      new CharacterBitmapDescriptor(CharacterPart.ARMOR, 'purple_cloth');

  // bodies
  static final CharacterBitmapDescriptor WHITE_BODY =
      new CharacterBitmapDescriptor(CharacterPart.BODY, 'white');

  // faces
  static final CharacterBitmapDescriptor WHITE_FACE_BLUE_EYES =
      new CharacterBitmapDescriptor(CharacterPart.FACE, 'white_with_blue_eyes');

  // hairs
  static final CharacterBitmapDescriptor RED_HAIR =
      new CharacterBitmapDescriptor(CharacterPart.HAIR, 'red');

  static final List<CharacterBitmapDescriptor> VALUES = [
    PURPLE_CLOTH,
    WHITE_BODY,
    WHITE_FACE_BLUE_EYES,
    RED_HAIR
  ];

  CharacterPart _characterPart;
  String _fileName;

  CharacterBitmapDescriptor(this._characterPart, this._fileName);

  get characterPart => _characterPart;

  get fileName => _fileName;
}
