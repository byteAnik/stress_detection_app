import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stress_detection_app/constants/app_assets/assets_audio.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final AudioPlayer player = AudioPlayer();

  String phase = "Ready";
  String lastPhase = "";

  bool isRunning = false;
  bool soundEnabled = true;
  bool hapticsEnabled = true;
  bool _canVibrate = false;

  int totalSeconds = 180;
  int currentSeconds = 180;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _checkVibration();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.88,
          end: 1.12,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
      TweenSequenceItem(tween: ConstantTween(1.12), weight: 20),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.12,
          end: 0.88,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    _controller.addListener(() {
      final value = _controller.value;
      String newPhase = "";

      if (value < 0.4) {
        newPhase = "Inhale";
      } else if (value < 0.6) {
        newPhase = "Hold";
      } else {
        newPhase = "Exhale";
      }

      if (newPhase != phase) {
        setState(() => phase = newPhase);

        if (phase != lastPhase && phase != "Hold") {
          lastPhase = phase;
          _triggerFeedback();
        }
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  Future<void> _checkVibration() async {
    _canVibrate = await Vibration.hasVibrator() ?? false;
  }

  void _triggerFeedback() {
    if (isRunning) {
      if (hapticsEnabled && _canVibrate) {
        Vibration.vibrate(duration: 80);
      }

      if (soundEnabled) {
        try {
          if (phase == "Inhale") {
            player.play(AssetSource(AssetsAudio.inhale));
          } else if (phase == "Exhale") {
            player.play(AssetSource(AssetsAudio.exhale));
          }
        } catch (e) {
          debugPrint("Audio Error: $e");
        }
      }
    }
  }

  void startBreathing() {
    setState(() {
      isRunning = true;
    });
    _controller.repeat();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (currentSeconds > 0) {
        setState(() => currentSeconds--);
      } else {
        stopBreathing();
      }
    });
  }

  void stopBreathing() {
    _controller.stop();
    _controller.reset();
    timer?.cancel();
    setState(() {
      isRunning = false;
      phase = "Ready";
      lastPhase = "";
      currentSeconds = totalSeconds;
    });
  }

  String formatTime(int sec) {
    int min = sec ~/ 60;
    int s = sec % 60;
    return "${min}:${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: UIHelper.kDefaulutPadding(),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Header
                      Column(
                        children: [
                          UIHelper.verticalSpace(20.h),
                          Text(
                            "Breathing Exercise",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      // Central Visualizer
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          double scale =
                              isRunning ? _scaleAnimation.value : 1.0;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              _buildConcentricCircle(330.w * scale, 0.05),
                              _buildConcentricCircle(270.w * scale, 0.08),
                              _buildConcentricCircle(210.w * scale, 0.12),

                              Container(
                                width: 155.w * (isRunning ? scale : 1.0),
                                height: 155.w * (isRunning ? scale : 1.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFF6D3F),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFFF6D3F,
                                      ).withOpacity(0.32),
                                      blurRadius: 40,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    phase,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      // Footer Section (Timer, Toggles, Controls)
                      Column(
                        children: [
                          Text(
                            formatTime(currentSeconds),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 8,
                            ),
                          ),
                          Text(
                            "Total: ${formatTime(totalSeconds)}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.35),
                              fontSize: 14.sp,
                            ),
                          ),

                          UIHelper.verticalSpace(30.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildToggle(
                                icon: Icons.volume_up,
                                label: "Sound",
                                isActive: soundEnabled,
                                onTap:
                                    () => setState(
                                      () => soundEnabled = !soundEnabled,
                                    ),
                              ),
                              UIHelper.horizontalSpace(20.w),
                              _buildToggle(
                                icon: Icons.vibration,
                                label: "Haptics",
                                isActive: hapticsEnabled,
                                onTap:
                                    () => setState(
                                      () => hapticsEnabled = !hapticsEnabled,
                                    ),
                              ),
                            ],
                          ),

                          UIHelper.verticalSpace(20.h),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF141414),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              children: [
                                _buildDurationItem("3 min", 180),
                                _buildDurationItem("5 min", 300),
                                _buildDurationItem("10 min", 600),
                              ],
                            ),
                          ),

                          UIHelper.verticalSpace(20.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: stopBreathing,
                                child: Container(
                                  width: 65.w,
                                  height: 65.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                  child: Icon(
                                    Icons.stop_rounded,
                                    color: Colors.white,
                                    size: 32.sp,
                                  ),
                                ),
                              ),
                              UIHelper.horizontalSpace(40.w),
                              GestureDetector(
                                onTap: isRunning ? null : startBreathing,
                                child: Container(
                                  width: 95.w,
                                  height: 95.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFFF6D3F),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFFF6D3F,
                                        ).withOpacity(0.4),
                                        blurRadius: 30,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isRunning
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 55.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpace(40.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildConcentricCircle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFF6D3F).withOpacity(opacity),
      ),
    );
  }

  Widget _buildToggle({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    Color orange = const Color(0xFFFF6D3F);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
            color: isActive ? orange : Colors.white10,
            width: 1.5,
          ),
          color: isActive ? orange.withOpacity(0.12) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? orange : Colors.white24, size: 20.sp),
            UIHelper.horizontalSpace(10.w),
            Text(
              label,
              style: TextStyle(
                color: isActive ? orange : Colors.white24,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationItem(String label, int seconds) {
    bool isSelected = totalSeconds == seconds;
    return Expanded(
      child: GestureDetector(
        onTap:
            isRunning
                ? null
                : () {
                  setState(() {
                    totalSeconds = seconds;
                    currentSeconds = seconds;
                  });
                },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: isSelected ? const Color(0xFF262626) : Colors.transparent,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white24,
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
