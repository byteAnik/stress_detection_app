import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/action_quick.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/ai_insight_card.dart';
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
                Row(
                  children: [
                    /// Profile Image (Network)
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: const NetworkImage(
                        "https://i.pravatar.cc/150?img=3", // demo image
                      ),
                    ),

                    UIHelper.horizontalSpace(12.w),

                    /// Greeting Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning,",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Alex Johnson",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// Notification Icon
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),

                        /// Red Dot Badge
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

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
