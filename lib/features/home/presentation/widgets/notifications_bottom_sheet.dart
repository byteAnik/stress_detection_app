import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class NotificationsBottomSheet extends StatelessWidget {
  const NotificationsBottomSheet({super.key});

  static final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.warning_amber_rounded,
      'iconColor': const Color(0xFFFFC107),
      'title': 'High Stress Detected',
      'subtitle': 'Your HRV dropped significantly in the last hour. Consider taking a break.',
      'time': '10 mins ago',
    },
    {
      'icon': Icons.auto_awesome,
      'iconColor': const Color(0xFF4CAF50),
      'title': 'Weekly Goal Met!',
      'subtitle': 'You completed 5 breathing exercises this week. Great job managing your stress.',
      'time': 'Yesterday',
    },
    {
      'icon': Icons.bar_chart_rounded,
      'iconColor': const Color(0xFF2196F3),
      'title': 'New Report Available',
      'subtitle': 'Your monthly stress analysis report is ready to view.',
      'time': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 16.sp),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          UIHelper.verticalSpace(24.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.4),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Divider(color: Colors.white.withOpacity(0.05)),
          UIHelper.verticalSpace(24.h),

          // Notification List
          ListView.separated(
            itemCount: _notifications.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => UIHelper.verticalSpace(12.h),
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              final Color iconColor = notification['iconColor'] as Color;

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification['icon'] as IconData,
                        color: iconColor,
                        size: 22.sp,
                      ),
                    ),
                    UIHelper.horizontalSpace(16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification['title'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          UIHelper.verticalSpace(6.h),
                          Text(
                            notification['subtitle'] as String,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14.sp,
                              height: 1.4,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          Text(
                            notification['time'] as String,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 12.sp,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          if (index != _notifications.length - 1)
                             Divider(color: Colors.white.withOpacity(0.03)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          UIHelper.verticalSpace(16.h),
        ],
      ),
    );
  }
}
