part of survive_game.resources;

class DirectoryPathResolver implements PathResolver {

  String _directory;
  String _extension;

  DirectoryPathResolver.ofDirectory(this._directory, this._extension);

  @override
  String resolvePath(String path) {
    return _directory + '/' + path + '.' + _extension;
  }

}
