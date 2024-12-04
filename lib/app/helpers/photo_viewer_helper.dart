// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:turbo_online_mobile/app/config/app_colors.dart';
// import 'package:turbo_online_mobile/generated/assets.dart';
//
// class PhotoViewerHelper {
//   static void show({
//     String? imageUrl,
//     Function()? onDelete,
//     ImageProvider? imageProvider,
//     bool? showDeleteButton = false,
//   }) {
//     var minScale = PhotoViewComputedScale.contained * 0.9;
//     var maxScale = PhotoViewComputedScale.covered * 2;
//     Get.dialog(
//       Container(
//         constraints: const BoxConstraints(minHeight: 300, minWidth: 400),
//         child: Stack(
//           children: [
//             PhotoView(
//               backgroundDecoration: const BoxDecoration(
//                 color: Colors.transparent,
//               ),
//               imageProvider: imageProvider ??
//                   (imageUrl != null
//                       ? CachedNetworkImageProvider(imageUrl)
//                       : const AssetImage(Assets.imagesTurboOnlineLogo3) as ImageProvider),
//               minScale: minScale,
//               maxScale: maxScale,
//               initialScale: minScale,
//             ),
//             Visibility(
//               visible: showDeleteButton == true,
//               child: Positioned(
//                 top: 16,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: () {
//                     onDelete?.call();
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white70,
//                       shape: BoxShape.circle,
//                     ),
//                     padding: const EdgeInsets.all(4),
//                     child: Icon(
//                       Icons.delete,
//                       color: AppColors.errorContainer,
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 16,
//               left: 16,
//               child: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white70,
//                     shape: BoxShape.circle,
//                   ),
//                   padding: const EdgeInsets.all(4),
//                   child: const Icon(Icons.close, color: Colors.black, size: 22),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       useSafeArea: true,
//     );
//   }
// }
