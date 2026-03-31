
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/onboarding_screen.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';
// Example HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 3), () {
    // 🔥 3 sec পরে execute হবে

    Get.to(()=>OnboardingScreen());
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.6,
              colors: [AppColors.c2A120D, AppColors.c0B0B0F],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.cFF6A3D, AppColors.c8B2C1E],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cFF6A3D.withOpacity(0.5),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.show_chart, // 🔥 waveform icon
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  "StressAI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  "Your AI Stress Companion",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
