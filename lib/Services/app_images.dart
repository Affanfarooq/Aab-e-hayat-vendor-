class AppImages {
  static const assetImagePath = 'assets/images/';
  static const iconsPath = 'assets/icons/';

  static String _concatPathAndImage(String icon, {String? path}) {
    return path == null ? assetImagePath + icon : path + icon;
  }

  // AppIcons
  static final imagePlaceHolderIcon =
      _concatPathAndImage("image_placeholder.svg");
  static final wellcomeImage = _concatPathAndImage("welcome_image");
}
