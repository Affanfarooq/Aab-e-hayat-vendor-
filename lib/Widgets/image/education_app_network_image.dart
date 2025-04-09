// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../Services/app_images.dart';
// import 'education_app_asset_image.dart';

// class EducationAppNetworkImage extends StatelessWidget {
//   final String imagePath;
//   final BoxFit fit;
//   final BoxFit errorAndPlaceHolderFit;
//   final double paddingValue;

//   const EducationAppNetworkImage(
//       {super.key,
//       required this.imagePath,
//       this.fit = BoxFit.contain,
//       this.errorAndPlaceHolderFit = BoxFit.contain,
//       this.paddingValue = 0});

//   @override
//   Widget build(BuildContext context) {
//     String imageServerUrl = ApiLinks.imagesUrl;
//     String imageUrl = imageServerUrl + imagePath;
//     final noImage = EducationAppAssetImage(
//       imagePath: AppImages.imagePlaceHolderIcon,
//       fit: errorAndPlaceHolderFit,
//     );

//     if (imagePath.isEmpty || imagePath == '') {
//       return noImage;
//     }

//     if (imagePath.toLowerCase().contains('.svg')) {
//       return SvgPicture.network(
//         imageUrl,
//         fit: fit,
//         placeholderBuilder: (context) => EducationAppNetworkImage(
//           imagePath: AppImages.imagePlaceHolderIcon,
//           fit: errorAndPlaceHolderFit,
//         ),
//       );
//     }
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       placeholder: (context, url) => EducationAppNetworkImage(
//         imagePath: AppImages.imagePlaceHolderIcon,
//         fit: errorAndPlaceHolderFit,
//       ),
//       errorWidget: (context, url, error) => noImage,
//       fit: errorAndPlaceHolderFit,
//     );
//   }
// }