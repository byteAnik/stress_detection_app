// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jolo1981_app/constants/app_assets/assets_icons.dart';
// import 'package:jolo1981_app/constants/app_colors.dart';
// import 'package:jolo1981_app/constants/text_font_style.dart';
// import 'package:jolo1981_app/helpers/ui_helpers.dart';
//
// import 'constants/app_assets/assets_icons.dart';
//
// final class WellcomeScreen extends StatelessWidget {
//   const WellcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(color: AppColors.scaffoldColor),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(AssetsIcons.logo, height: 40.h, width: 40.w),
//                 UIHelper.horizontalSpace(4.w),
//                 Image.asset(AssetsIcons.logoName, height: 30.h, width: 100.w),
//               ],
//             ),
//
//             UIHelper.verticalSpace(10.h),
//             Padding(
//               padding: EdgeInsets.only(left: 25.w),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 "Welcome to NomoMed",
//                 style: TextFontStyle.textStyle14Urbanist400c222222.copyWith(
//                   color: AppColors.c000311,
//                   height: 1.43,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
