import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy List for Settings
    final List<Map<String, dynamic>> settingsData = [
      {
        "icon": Icons.notifications_none_rounded,
        "title": "Notifications",
        "isSwitch": true,
        "switchValue": true,
      },
      {
        "icon": Icons.dark_mode_outlined,
        "title": "Dark Mode",
        "isSwitch": true,
        "switchValue": true,
      },
      {"icon": Icons.shield_outlined, "title": "Privacy & Security"},
      {"icon": Icons.file_download_outlined, "title": "Data Export"},
      {
        "icon": Icons.science_outlined,
        "title": "Research Mode",
        "iconColor": Colors.deepOrange,
      },
      {"icon": Icons.info_outline_rounded, "title": "About StressAI"},
      {"icon": Icons.help_outline_rounded, "title": "Help & Support"},
    ];

    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(20.h),

                /// Title
                Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                UIHelper.verticalSpace(30.h),

                /// Profile Card
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.02),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      /// Avatar + Edit
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.deepOrange,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 45.r,
                              backgroundImage: const NetworkImage(
                                "https://i.pravatar.cc/150?img=3",
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white10,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Name
                      Text(
                        "Alex Johnson",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      UIHelper.verticalSpace(6.h),

                      /// Email
                      Text(
                        "alex.johnson@email.com",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.sp,
                        ),
                      ),

                      UIHelper.verticalSpace(16.h),

                      /// Divider
                      Container(height: 1, color: Colors.white10),

                      UIHelper.verticalSpace(16.h),

                      /// Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn('14', 'Sessions'),
                          _buildVerticalDivider(),
                          _buildStatColumn('45', 'Avg Score'),
                          _buildVerticalDivider(),
                          _buildStatColumn('2m', 'Member'),
                        ],
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(20.h),
                Text(
                  'Connected Devices',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                _buildDeviceTile(
                  icon: Icons.watch,
                  title: "Apple Watch",
                  status: "Connected",
                  actionText: "Disconnect",
                  iconColor: Colors.green,
                ),
                UIHelper.verticalSpace(12.h),
                _buildDeviceTile(
                  icon: Icons.mobile_off_outlined,
                  title: "Fitbit",
                  status: "Not Connected",
                  actionText: "Connect",
                  iconColor: Colors.white54,
                ),

                UIHelper.verticalSpace(30.h),

                // --- Settings Section (ListView.builder with inlined logic) ---
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: const Color(0xFF1A1A1A),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: settingsData.length,
                    separatorBuilder:
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                    itemBuilder: (context, index) {
                      final item = settingsData[index];
                      final bool isSwitch = item["isSwitch"] ?? false;
                      final bool switchValue = item["switchValue"] ?? false;
                      final Color? iconColor = item["iconColor"];

                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                item["icon"],
                                color: iconColor ?? Colors.white70,
                                size: 20.sp,
                              ),
                            ),
                            UIHelper.horizontalSpace(16.w),
                            Text(
                              item["title"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            if (isSwitch)
                              Switch(
                                value: switchValue,
                                onChanged: (v) {},
                                activeColor: Colors.white,
                                activeTrackColor: Colors.deepOrange,
                              )
                            else
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white24,
                                size: 22.sp,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20.sp),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Image.asset(
          AssetsIcons.questionMarkIcon,
          height: 20.h,
          width: 20.w,
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        UIHelper.verticalSpace(4.h),
        Text(label, style: TextStyle(color: Colors.white54, fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildDeviceTile({
    required IconData icon,
    required String title,
    required String status,
    required String actionText,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          UIHelper.horizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  status,
                  style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Text(
            actionText,
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 25.h, color: Colors.white12);
  }
}
