import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

import 'package:stress_detection_app/features/monitoring/presentation/widgets/monitoring_stats_card.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  bool isActive = false;
  bool showHistory = false;
  int bpm = 82;
  int hrv = 41;
  int _secondsElapsed = 0;
  Timer? _monitoringTimer;
  final Random _random = Random();

  final List<Map<String, dynamic>> pastSessions = [
    {'time': 'Today, 10:30 AM', 'duration': '15m session', 'bpm': '72'},
    {'time': 'Yesterday, 2:15 PM', 'duration': '45m session', 'bpm': '82'},
  ];

  @override
  void dispose() {
    _monitoringTimer?.cancel();
    super.dispose();
  }

  void toggleMonitoring() {
    setState(() {
      isActive = !isActive;
      if (isActive) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  void _startTimer() {
    _secondsElapsed = 0;
    _monitoringTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
        // Simulate live fluctuations
        bpm = 70 + _random.nextInt(15); // fluctuates between 70-85
        hrv = 45 + _random.nextInt(10); // fluctuates between 45-55
      });
    });
  }

  void _stopTimer() {
    _monitoringTimer?.cancel();
  }

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stats = [
      {
        'icon': Icons.favorite_border_rounded,
        'title': "Heart\nRate",
        'value': "$bpm",
        'unit': "bpm",
        'iconColor': Colors.redAccent,
        'iconBgColor': Colors.red.withOpacity(0.1),
      },
      {
        'icon': Icons.monitor_heart_outlined,
        'title': "HRV",
        'value': "$hrv",
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
            child: Column(
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
                      onPressed: () {
                        setState(() {
                          showHistory = !showHistory;
                        });
                      },
                      icon: Icon(
                        Icons.history_rounded,
                        color:
                            showHistory
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
                        color: isActive ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      isActive ? "Monitoring Active" : "Ready to Monitor",
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
                            "$bpm",
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
                              isActive: isActive,
                              seed:
                                  _secondsElapsed, // Use seconds to animate the wave
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
                if (showHistory) ...[
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
                    itemCount: pastSessions.length,
                    itemBuilder: (context, index) {
                      final session = pastSessions[index];
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
                    _formatTime(_secondsElapsed),
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
                        onTap: toggleMonitoring,
                        child: Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color:
                                isActive
                                    ? Colors.transparent
                                    : const Color(0xFFFF5722),
                            border:
                                isActive
                                    ? Border.all(
                                      color: Colors.red.withOpacity(0.5),
                                      width: 2,
                                    )
                                    : null,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(isActive ? 4 : 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isActive
                                      ? const Color(0xFF151517)
                                      : Colors.transparent,
                              shape: BoxShape.circle,
                              border:
                                  isActive
                                      ? Border.all(color: Colors.red, width: 2)
                                      : null,
                            ),
                            child: Center(
                              child:
                                  isActive
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
                        isActive ? "Tap to Stop" : "Tap to Start",
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
    );
  }
}

class WavePainter extends CustomPainter {
  final bool isActive;
  final int seed;
  WavePainter({required this.isActive, required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFF3B30)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Simple wavy path for demonstration, randomized slightly by seed
    double x = 0;
    while (x < size.width) {
      double fluctuation = isActive ? (sin(seed + x) * 10) : 0;
      path.lineTo(
        x + 20,
        size.height *
            (0.6 +
                (isActive ? 0.2 : 0.1) * (x % 60 == 0 ? 1 : -1) +
                (fluctuation / 100)),
      );
      path.lineTo(
        x + 40,
        size.height *
            (0.5 +
                (isActive ? 0.3 : 0.15) * (x % 80 == 0 ? -1 : 1) -
                (fluctuation / 100)),
      );
      x += 40;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
