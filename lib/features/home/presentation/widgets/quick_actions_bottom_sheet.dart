import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class QuickActionsBottomSheet extends StatelessWidget {
  const QuickActionsBottomSheet({super.key});

  static final List<Map<String, dynamic>> _quickActions = [
    {
      'icon': Icons.favorite_rounded,
      'iconColor': const Color(0xFFFF5722),
      'title': 'New Session',
      'subtitle': 'Start monitoring your stress',
      'isEmergency': false,
    },
    {
      'icon': Icons.show_chart_rounded,
      'iconColor': const Color(0xFF4CAF50),
      'title': 'Quick Check',
      'subtitle': '3-minute breathing exercise',
      'isEmergency': false,
    },
    {
      'icon': Icons.shield_outlined,
      'iconColor': const Color(0xFFFF5722),
      'title': 'Emergency SOS',
      'subtitle': 'Contact your support network',
      'isEmergency': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
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
                'Quick Actions',
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

          // Action List
          ListView.builder(
            itemCount: _quickActions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final action = _quickActions[index];
              final bool isEmergency = action['isEmergency'] as bool;
              final Color iconColor = action['iconColor'] as Color;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color:
                          isEmergency
                              ? const Color(0xFF2A120D).withOpacity(0.5)
                              : const Color(0xFF27272A).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20.r),
                      border:
                          isEmergency
                              ? Border.all(
                                color: const Color(0xFF8B2C1E),
                                width: 1.5,
                              )
                              : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color:
                                isEmergency
                                    ? const Color(0xFF8B2C1E).withOpacity(0.3)
                                    : const Color(0xFF3F3F46).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            action['icon'] as IconData,
                            color: iconColor,
                            size: 26.sp,
                          ),
                        ),
                        UIHelper.horizontalSpace(16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                action['title'] as String,
                                style: TextStyle(
                                  color:
                                      isEmergency
                                          ? const Color(0xFFFF5a2c)
                                          : Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              UIHelper.verticalSpace(4.h),
                              Text(
                                action['subtitle'] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
