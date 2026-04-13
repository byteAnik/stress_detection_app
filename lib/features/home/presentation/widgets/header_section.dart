import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';
import 'package:stress_detection_app/features/home/presentation/widgets/notifications_bottom_sheet.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const NotificationsBottomSheet(),
            );
          },
          borderRadius: BorderRadius.circular(30.r),
          child: Stack(
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
        ),
      ],
    );
  }
}
