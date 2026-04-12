import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class RecommentdationScreen extends StatelessWidget {
  const RecommentdationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of recommendations matching the design
    final List<Map<String, dynamic>> recommendations = [
      {
        "title": "Breathing Exercise",
        "description": "A 5-minute guided session to lower your heart rate.",
        "icon": Icons.air_rounded,
        "color": Color(0xFF4CAF50), // Greenish
        "buttonText": "Start",
        "isPrimary": true,
      },
      {
        "title": "Take a Walk",
        "description": "15 minutes of outdoor activity to reset your focus.",
        "icon": Icons.directions_walk_rounded,
        "color": Color(0xFFFFD700), // Yellow
        "buttonText": "Set Reminder",
        "isPrimary": false,
      },
      {
        "title": "Reduce Screen Time",
        "description": "Limit evening usage to improve sleep quality.",
        "icon": Icons.smartphone_rounded,
        "color": Color(0xFFFF5252), // Reddish
        "buttonText": "Learn More",
        "isPrimary": false,
      },
      {
        "title": "Sleep Optimization",
        "description": "Step-by-step guide to improve your sleep hygiene.",
        "icon": Icons.bedtime_rounded,
        "color": Color(0xFF9C27B0), // Purple
        "buttonText": "Get Started",
        "isPrimary": false,
      },
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
              children: [
                /// Top Header
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Recommendations',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 18.sp), // For centering balance
                  ],
                ),

                /// Everything inside ListView.builder as requested
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  itemCount:
                      recommendations.length + 1, // +1 for the top banner
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      /// Top Highlight Banner
                      return Container(
                        margin: EdgeInsets.only(bottom: 24.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF3D1B1B), // Darker brownish/red
                              Color(0xFF1F1F1F),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                            UIHelper.horizontalSpace(16.w),
                            Text(
                              'Based on your recent high\nstress levels',
                              style: TextStyle(
                                color: Colors.white.withAlpha(220),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Data for current recommendation card
                    final data = recommendations[index - 1];
                    final Color accentColor = data['color'];

                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          /// Left side color bar
                          Positioned(
                            left: 0,
                            top: 15.h,
                            bottom: 15.h,
                            child: Container(
                              width: 3.w,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),

                          /// Card Content
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Left Icon with background
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: accentColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Icon(
                                        data['icon'],
                                        color: accentColor,
                                        size: 24.sp,
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(16.w),

                                    /// Title and Description
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['title'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          UIHelper.verticalSpace(8.h),
                                          Text(
                                            data['description'],
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 12.sp,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// Heart Icon
                                    Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.white24,
                                      size: 20.sp,
                                    ),
                                  ],
                                ),

                                UIHelper.verticalSpace(20.h),

                                /// Action Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          data['isPrimary']
                                              ? Colors.deepOrange
                                              : Color(0xFF262626),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14.h,
                                      ),
                                    ),
                                    child: Text(
                                      data['buttonText'],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
