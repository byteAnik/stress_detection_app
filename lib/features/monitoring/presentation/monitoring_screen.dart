import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/getx_controller/monitoring_controller.dart';
import 'package:stress_detection_app/features/monitoring/presentation/widgets/wave_painter.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';
import 'package:stress_detection_app/features/monitoring/presentation/widgets/monitoring_stats_card.dart';
// Import the controller

class MonitoringScreen extends StatelessWidget {
  MonitoringScreen({super.key});

  final MonitoringController controller = Get.put(MonitoringController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stats = [
      {
        'icon': Icons.favorite_border_rounded,
        'title': "Heart\nRate",
        'value': controller.bpm.value.toString(),
        'unit': "bpm",
        'iconColor': Colors.redAccent,
        'iconBgColor': Colors.red.withOpacity(0.1),
      },
      {
        'icon': Icons.monitor_heart_outlined,
        'title': "HRV",
        'value': controller.hrv.value.toString(),
        'unit': "ms",
        'iconColor': Colors.greenAccent,
        'iconBgColor': Colors.green.withOpacity(0.1),
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
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(20.h),

                  /// Custom AppBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        "Live Monitoring",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.toggleHistory,
                        icon: Icon(
                          Icons.history_rounded,
                          color:
                              controller.showHistory.value
                                  ? const Color(0xFFFF5722)
                                  : Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(24.h),

                  /// Status Indicator
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color:
                              controller.isActive.value
                                  ? Colors.green
                                  : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        controller.isActive.value
                            ? "Monitoring Active"
                            : "Ready to Monitor",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(24.h),

                  /// Main Pulse Chart Card
                  Container(
                    width: double.infinity,
                    height: 240.h,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151517),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${controller.bpm.value}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            UIHelper.horizontalSpace(4.w),
                            Text(
                              "BPM",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFFF3B30).withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: CustomPaint(
                              painter: WavePainter(
                                isActive: controller.isActive.value,
                                seed: controller.secondsElapsed.value,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  UIHelper.verticalSpace(24.h),

                  /// Stats Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      mainAxisExtent: 100.h,
                    ),
                    itemCount: stats.length,
                    itemBuilder: (context, index) {
                      final item = stats[index];
                      return MonitoringStatsCard(
                        icon: item['icon'] as IconData,
                        title: item['title'] as String,
                        value: item['value'] as String,
                        unit: item['unit'] as String,
                        iconColor: item['iconColor'] as Color,
                        iconBgColor: item['iconBgColor'] as Color,
                      );
                    },
                  ),

                  /// Past Sessions Section (Conditional)
                  if (controller.showHistory.value) ...[
                    UIHelper.verticalSpace(32.h),
                    Text(
                      "Past Sessions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.pastSessions.length,
                      itemBuilder: (context, index) {
                        final session = controller.pastSessions[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF151517),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    session['time']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  UIHelper.verticalSpace(4.h),
                                  Text(
                                    session['duration']!,
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: session['bpm']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " bpm",
                                      style: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12.sp,
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

                  UIHelper.verticalSpace(48.h),

                  /// Timer
                  Center(
                    child: Text(
                      controller.formatTime(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),

                  UIHelper.verticalSpace(48.h),

                  /// Action Button
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: controller.toggleMonitoring,
                          child: Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color:
                                  controller.isActive.value
                                      ? Colors.transparent
                                      : const Color(0xFFFF5722),
                              border:
                                  controller.isActive.value
                                      ? Border.all(
                                        color: Colors.red.withOpacity(0.5),
                                        width: 2,
                                      )
                                      : null,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(
                              controller.isActive.value ? 4 : 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    controller.isActive.value
                                        ? const Color(0xFF151517)
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                                border:
                                    controller.isActive.value
                                        ? Border.all(
                                          color: Colors.red,
                                          width: 2,
                                        )
                                        : null,
                              ),
                              child: Center(
                                child:
                                    controller.isActive.value
                                        ? Container(
                                          width: 24.w,
                                          height: 24.w,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              4.r,
                                            ),
                                          ),
                                        )
                                        : Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 48.sp,
                                        ),
                              ),
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),
                        Text(
                          controller.isActive.value
                              ? "Tap to Stop"
                              : "Tap to Start",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
