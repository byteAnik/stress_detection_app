import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/action_quick.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/ai_insight_card.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/header_section.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/recent_session.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/stress_level_card.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderSection(),
                UIHelper.verticalSpace(24.h),
                StressLevelCard(),
                UIHelper.verticalSpace(24.h),
                AiInsightCard(),
                UIHelper.verticalSpace(32.h),
                ActionQuick(),
                UIHelper.verticalSpace(32.h),
                RecentSession(),
                UIHelper.verticalSpace(80.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF5722),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 32.sp),
      ),
    );
  }
}
