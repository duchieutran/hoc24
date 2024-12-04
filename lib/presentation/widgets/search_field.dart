// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../app/config/app_colors.dart';
//
// class SearchField extends StatelessWidget {
//   const SearchField({
//     super.key,
//     required this.controller,
//     this.onChanged,
//     this.hintText,
//     this.label,
//     this.width,
//     this.onSubmitted,
//   });
//
//   final TextEditingController controller;
//   final void Function(String)? onChanged;
//   final String? hintText;
//   final String? label;
//   final double? width;
//   final Function(String)? onSubmitted;
//
//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context)!;
//     return Container(
//         width: width,
//         color: AppColors.light,
//         child: TextField(
//           textAlignVertical: TextAlignVertical.center,
//           onChanged: onChanged,
//           controller: controller,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 color: AppColors.darkBackground,
//                 fontSize: 14,
//               ),
//           decoration: InputDecoration(
//             hintText: hintText ?? t.search,
//             labelText: label,
//             suffixIcon: const Icon(Icons.search),
//             contentPadding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
//             suffixIconColor: AppColors.lightGrey,
//             enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 1, color: AppColors.lightGrey),
//                 borderRadius: BorderRadius.circular(4.0)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1, color: AppColors.grey), borderRadius: BorderRadius.circular(4.0)),
//             hintStyle: Theme.of(context).textTheme.bodyMedium,
//           ),
//           onSubmitted: onSubmitted ??
//               (value) {
//                 controller.clear();
//               },
//         ));
//   }
// }
