import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/analytics/presentation/analytics_screen.dart';
import 'package:stress_detection_app/features/breathing/presentation/breathing_screen.dart';
import 'package:stress_detection_app/features/home/presentation/home_screen.dart';
import 'package:stress_detection_app/features/monitoring/presentation/monitoring_screen.dart';
import 'package:stress_detection_app/features/profile/presentation/profile_screen.dart';
import 'package:stress_detection_app/helpers/helper_methods.dart';
import 'package:svg_flutter/svg.dart';

class NavigationBarScreen extends StatefulWidget {
  final int? pageNum;
  const NavigationBarScreen({super.key, this.pageNum});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  late int _currentIndex;

  final List<Widget> _screens = [
    HomeScreen(),
    MonitoringScreen(),
    AnalyticsScreen(),
    BreathingScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showMaterialDialog(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.c1B1B1B,
        extendBody: true,
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.c1B1B1B,
            border: Border(
              top: BorderSide(
                color: const Color(0xFF2A2A2A),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.18 * 255).toInt()),
                blurRadius: 16,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: AppColors.c1B1B1B,
              currentIndex: _currentIndex,
              onTap: (index) {
                log("----------------index--$index");
                setState(() => _currentIndex = index);
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: const Color(0xFFFF5A1F),
              unselectedItemColor: const Color(0xFF8B8A8C),
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              iconSize: 24.sp,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                height: 1.2,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                height: 1.2,
              ),
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              items: [
                _buildNavItem(
                  iconPath: AssetsIcons.homeIcon,
                  label: "Home",
                  index: 0,
                  isSvg: false,
                ),
                _buildNavItem(
                  iconPath: AssetsIcons.analyzeIcon,
                  label: "Monitor",
                  index: 1,
                  isSvg: false,
                ),
                _buildNavItem(
                  iconPath: AssetsIcons.chartIcon,
                  label: "Analysis",
                  index: 2,
                  isSvg: false,
                ),
                _buildNavItem(
                  iconPath: AssetsIcons.congnitiveIcon,
                  label: "Therapy",
                  index: 3,
                  isSvg: false,
                ),
                _buildNavItem(
                  iconPath: AssetsIcons.personIcon,
                  label: "Profile",
                  index: 4,
                  isSvg: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
    required bool isSvg,
  }) {
    final bool isSelected = _currentIndex == index;
    final Color color = isSelected
        ? const Color(0xFFFF5A1F)
        : const Color(0xFF8B8A8C);

    Widget iconWidget;

    if (isSvg) {
      iconWidget = Padding(
        padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
        child: SvgPicture.asset(
          iconPath,
          height: 22.h,
          width: 22.w,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      );
    } else {
      iconWidget = Padding(
        padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
        child: Image.asset(
          iconPath,
          height: 22.h,
          width: 22.w,
          color: color,
        ),
      );
    }

    return BottomNavigationBarItem(
      icon: iconWidget,
      activeIcon: isSvg
          ? Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
              child: SvgPicture.asset(
                iconPath,
                height: 22.h,
                width: 22.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF5A1F),
                  BlendMode.srcIn,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
              child: Image.asset(
                iconPath,
                height: 22.h,
                width: 22.w,
                color: const Color(0xFFFF5A1F),
              ),
            ),
      label: label,
    );
  }
}