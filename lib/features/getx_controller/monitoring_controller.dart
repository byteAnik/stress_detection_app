import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  var isActive = false.obs;
  var showHistory = false.obs;
  var bpm = 82.obs;
  var hrv = 41.obs;
  var secondsElapsed = 0.obs;

  final Random _random = Random();
  Timer? _monitoringTimer;

  final List<Map<String, dynamic>> pastSessions = [
    {'time': 'Today, 10:30 AM', 'duration': '15m session', 'bpm': '72'},
    {'time': 'Yesterday, 2:15 PM', 'duration': '45m session', 'bpm': '82'},
  ];

  void toggleMonitoring() {
    isActive.value = !isActive.value;
    if (isActive.value) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  void toggleHistory() {
    showHistory.value = !showHistory.value;
  }

  void startTimer() {
    secondsElapsed.value = 0;
    _monitoringTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsElapsed.value++;
      bpm.value = 70 + _random.nextInt(15); // 70-85 bpm
      hrv.value = 45 + _random.nextInt(10); // 45-55 ms
    });
  }

  void stopTimer() {
    _monitoringTimer?.cancel();
  }

  String formatTime() {
    final mins = secondsElapsed.value ~/ 60;
    final secs = secondsElapsed.value % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    _monitoringTimer?.cancel();
    super.onClose();
  }
}
