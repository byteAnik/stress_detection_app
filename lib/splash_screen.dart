// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jolo1981_app/choose_language.dart';
// import 'package:jolo1981_app/helpers/ui_helpers.dart';
// import 'package:get/get.dart';
// import 'package:jolo1981_app/helpers/ui_helpers.dart';
//
// import 'choose_language.dart';
// import 'constants/app_assets/assets_icons.dart';
// import 'constants/app_colors.dart';
//
// final class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     initial();
//   }
//
//   initial() async {
//     await Future.delayed(Duration(seconds: 3));
//     await Get.to(() => ChooseLanguageScreen());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(color: AppColors.scaffoldColor),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(AssetsIcons.logo, height: 40.h, width: 40.w),
//             UIHelper.horizontalSpace(4.w),
//             Image.asset(AssetsIcons.logoName, height: 30.h, width: 100.w),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // new branch
//     return Scaffold(
      
//       body: Center(
//         child: Text("Splash Screen"),
//       ),
//     );
//   }
// }
