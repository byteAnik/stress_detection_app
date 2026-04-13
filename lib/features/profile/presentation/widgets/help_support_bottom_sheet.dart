import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class HelpSupportBottomSheet extends StatelessWidget {
  const HelpSupportBottomSheet({super.key});

  static final List<Map<String, dynamic>> _supportOptions = [
    {
      'icon': Icons.chat_bubble_outline_rounded,
      'iconColor': const Color(0xFFFF5722),
      'title': 'Live Chat',
      'subtitle': 'Typically replies in 5 mins',
    },
    {
      'icon': Icons.description_outlined,
      'iconColor': const Color(0xFF4CAF50),
      'title': 'FAQs & Guides',
      'subtitle': 'Browse our knowledge base',
    },
    {
      'icon': Icons.email_outlined,
      'iconColor': const Color(0xFF2196F3),
      'title': 'Email Support',
      'subtitle': 'support@stressai.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 24.sp),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          UIHelper.verticalSpace(24.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Help & Support',
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
          UIHelper.verticalSpace(16.h),

          // Description Text
          Text(
            "Need assistance? We're here to help you manage\nyour stress journey.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15.sp,
              height: 1.5,
            ),
          ),
          UIHelper.verticalSpace(24.h),

          // Options List
          ListView.builder(
            itemCount: _supportOptions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final option = _supportOptions[index];
              final Color iconColor = option['iconColor'] as Color;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27272A).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: iconColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            option['icon'] as IconData,
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
                                option['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              UIHelper.verticalSpace(4.h),
                              Text(
                                option['subtitle'] as String,
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
