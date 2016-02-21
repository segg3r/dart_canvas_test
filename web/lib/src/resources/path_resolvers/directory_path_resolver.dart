part of survive_game.resources;

class DirectoryPathResolver implements PathResolver {

  static final String PATH_SPLITTER = '/';
  static final String EXTENSION_SPLITTER = '.';

  String _directory;
  String _extension;

  DirectoryPathResolver.ofDirectory(this._directory, this._extension);

  @override
  String resolvePath(String path) {
    return _directory + PATH_SPLITTER + path + EXTENSION_SPLITTER + _extension;
  }

}
