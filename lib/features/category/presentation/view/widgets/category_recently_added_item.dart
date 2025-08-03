// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:his/core/utils/app_text_styles.dart';
// import 'package:his/core/utils/assets.dart';

// import '../../../../../core/utils/app_colors.dart';

// class CategoryRecentlyAddedItem extends StatelessWidget {
//   const CategoryRecentlyAddedItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 198 / 250,
//       child: Container(
//         decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//               side: const BorderSide(color: AppColors.lightGrey, width: 1)),
//         ),
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 198 / 105,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12)),
//                 child: Image.asset(
//                   Assets.assetsImagesDoctestimage,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Lorem ipsum dolor sit amet consectetur.',
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 3,
//                     style: Styles.semiBoldPoppins14,
//                   ),
//                   const Text(
//                     'Lorem ipsum dolor sit amet consectetur. In neque quisque .',
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 3,
//                     style: Styles.regularRoboto12,
//                   ),
//                   const Divider(),
//                   Row(
//                     children: [
//                       SvgPicture.asset(Assets.assetsImagesCheckicon),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Text(
//                         'Last viewed : 2 h ago ',
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                         style: Styles.semiBoldRoboto12
//                             .copyWith(color: AppColors.grey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
