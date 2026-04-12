import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:stress_detection_app/features/recommenntdation/presentation/recommentdation_screen.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class ActionQuick extends StatelessWidget {
  final List<Map<String, dynamic>> quickActions = [
    {
      'icon': Icons.show_chart,
      'label': 'Monitor',
      'bgColor': const Color(0x26FF9800), // Orange with 15% opacity
      'iconColor': Colors.orange,
    },
    {
      'icon': Icons.bar_chart_rounded,
      'label': 'Report',
      'bgColor': const Color(0x264CAF50), // Green with 15% opacity
      'iconColor': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline_rounded,
      'label': 'Tips',
      'bgColor': const Color(0x26FFEB3B), // Yellow with 15% opacity
      'iconColor': Colors.yellow,
    },
  ];
  ActionQuick({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          "Quick Actions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        UIHelper.verticalSpace(12.h),

        /// Horizontal List
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quickActions.length,
            itemBuilder: (context, index) {
              final action = quickActions[index];

              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                  } else if (index == 1) {
                  } else if (index == 2) {
                    Get.to(() => RecommentdationScreen());
                  }
                },
                child: Container(
                  width: 105.w,
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151517),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Icon Circle
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: action['bgColor'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          action['icon'] as IconData,
                          color: action['iconColor'] as Color,
                          size: 26.sp,
                        ),
                      ),

                      UIHelper.verticalSpace(12.h),

                      /// Label
                      Text(
                        action['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
