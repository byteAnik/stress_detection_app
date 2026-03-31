import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  bool isAccepted = false;

  final List<Map<String, String>> data = [
    {
      "title": "AI-Powered Detection",
      "subtitle":
          "Real-time stress detection using advanced AI algorithms to keep you balanced.",
      "icon": AssetsIcons.brainIcon,
    },
    {
      "title": "Multiple Data Sources",
      "subtitle":
          "We analyze HRV, BPM, and behavioral patterns to give you accurate insights.",
      "icon": AssetsIcons.heartIcon,
    },
    {
      "title": "Your Data is Safe",
      "subtitle":
          "End-to-end encryption ensures your health data remains private and secure.",
      "icon": AssetsIcons.shieldIcon,
    },
    {
      "title": "Smart Recommendations",
      "subtitle":
          "Get personalized actionable advice to manage and reduce your stress levels.",
      "icon": AssetsIcons.lightIcon,
    },
  ];

  void nextPage() {
    if (currentIndex == data.length - 1) {
      // TODO: Navigate Home
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
            vertical: 10.h,
          ),
          child: Column(
            children: [
              /// 🔥 Top Progress + Skip
              Row(
                children: [
                  /// 🔥 Progress bar (FIXED)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4.h,
                      child: Stack(
                        children: [
                          /// Background line
                          Container(
                            width: double.infinity,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),

                          /// 🔥 Active progress
                          FractionallySizedBox(
                            widthFactor: (currentIndex + 1) / data.length,
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: AppColors.cFF5A2C,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  /// 🔥 Skip (hide on last)
                  if (currentIndex != data.length - 1)
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(data.length - 1);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                ],
              ),

              UIHelper.verticalSpace(40.h),

              /// 🔥 PageView
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: data.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final item = data[index];

                    return Column(
                      children: [
                        /// 🔥 Circle + Icon
                        Container(
                          height: 220.h,
                          width: 220.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.08),
                                Colors.white.withOpacity(0.02),
                              ],
                            ),
                            border:
                                index == 3
                                    ? Border.all(
                                      color: AppColors.cFF5A2C.withOpacity(0.5),
                                      width: 2,
                                    )
                                    : Border.all(
                                      color: Colors.white.withOpacity(0.06),
                                    ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    index == 3
                                        ? AppColors.cFF5A2C.withOpacity(0.4)
                                        : Colors.black.withOpacity(0.7),
                                blurRadius: 50,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              item["icon"]!,
                              width: 90.w,
                              height: 90.h,
                              color: AppColors.cFF5A2C,
                            ),
                          ),
                        ),

                        UIHelper.verticalSpace(40.h),

                        /// 🔥 Title
                        Text(
                          item["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        UIHelper.verticalSpace(16.h),

                        /// 🔥 Subtitle
                        Text(
                          item["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),

                        /// 🔥 3rd screen checkbox
                        if (index == 2) ...[
                          UIHelper.verticalSpace(25.h),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAccepted = !isAccepted;
                                    });
                                  },
                                  child: Container(
                                    height: 20.h,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                      color:
                                          isAccepted
                                              ? AppColors.cFF5A2C
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        color:
                                            isAccepted
                                                ? AppColors.cFF5A2C
                                                : Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                    child:
                                        isAccepted
                                            ? const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            )
                                            : null,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                Expanded(
                                  child: Text(
                                    "I accept the privacy policy",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),

              /// 🔥 Dot Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  data.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: currentIndex == index ? 20.w : 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color:
                          currentIndex == index
                              ? AppColors.cFF5A2C
                              : Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),

              UIHelper.verticalSpace(30.h),

              /// 🔥 Button
              CommonButton(
                text: currentIndex == data.length - 1 ? "Get Started" : "Next",
                onPressed: () {
                  if (currentIndex == 2 && !isAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please accept privacy policy"),
                      ),
                    );
                    return;
                  }
                  nextPage();
                },
              ),

              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
