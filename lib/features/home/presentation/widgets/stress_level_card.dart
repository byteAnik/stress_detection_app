import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class StressLevelCard extends StatelessWidget {
  const StressLevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF151517), // Darker card background
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Stress Level",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          UIHelper.verticalSpace(32.h),
          Center(
            child: CircularPercentIndicator(
              radius: 100.r,
              lineWidth: 18.w,
              percent: 0.72,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey.shade900,
              progressColor: const Color(0xFFFF3B30), // Red color from image
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "72",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "High",
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
