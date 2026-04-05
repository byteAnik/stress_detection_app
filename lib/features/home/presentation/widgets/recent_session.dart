import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class RecentSession extends StatelessWidget {
  RecentSession({super.key});
  final List<Map<String, dynamic>> recentSessions = [
    {
      'time': 'Today, 10:30 AM',
      'duration': '15 min',
      'stressType': 'Low Stress',
      'value': 45,
      'color': Colors.green,
    },
    {
      'time': 'Yesterday, 2:15 PM',
      'duration': '45 min',
      'stressType': 'High Stress',
      'value': 82,
      'color': Colors.red,
    },
    {
      'time': 'Mon, 9:00 AM',
      'duration': '30 min',
      'stressType': 'Moderate Stress',
      'value': 60,
      'color': Colors.orange,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Sessions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                color: const Color(0xFFFF3B30),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        UIHelper.verticalSpace(16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentSessions.length,
          itemBuilder: (context, index) {
            final session = recentSessions[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF151517),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  /// Colored Indicator Bar
                  Container(
                    width: 6.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: session['color'] as Color,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),

                  /// Session Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session['time'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          "${session['duration']} • ${session['stressType']}",
                          style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),

                  /// Mini Chart (Demo)
                  Icon(
                    Icons.waves_rounded,
                    color: (session['color'] as Color).withOpacity(0.5),
                    size: 24.sp,
                  ),
                  UIHelper.horizontalSpace(16.w),

                  /// Stress Value
                  Text(
                    "${session['value']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
