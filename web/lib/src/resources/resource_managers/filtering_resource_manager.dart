part of survive_game.resources;

class FilteringResourceManager extends ResourceManager {

  List<String> _bitmapsToFilter = new List<String>();
  List<ImageDataFilter> _imageDataFilters;

  FilteringResourceManager(this._imageDataFilters) : super();

  @override
  void addBitmapData(String name, String url,
      [BitmapDataLoadOptions bitmapDataLoadOptions = null]) {
    super.addBitmapData(name, url, bitmapDataLoadOptions);
    _bitmapsToFilter.add(name);
  }

  @override
  Future<ResourceManager> load() async {
    ResourceManager result = await super.load();
    for (String bitmapName in _bitmapsToFilter) {
      _filterBitmap(bitmapName);
    }
    return result;
  }

  void _filterBitmap(String bitmapName) {
    BitmapData importedBitmapData = super.getBitmapData(bitmapName);
    RenderTextureQuad renderTextureQuad = importedBitmapData.renderTextureQuad;
    ImageData imageData = renderTextureQuad.getImageData();
    ImageData filteredImageData = _passThroughFilters(imageData);
    renderTextureQuad.putImageData(filteredImageData);
  }

  ImageData _passThroughFilters(ImageData imageData) {
    for (ImageDataFilter imageDataFilter in _imageDataFilters) {
      imageData = imageDataFilter.filter(imageData);
    }
    return imageData;
  }

}
