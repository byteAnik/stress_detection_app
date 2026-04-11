import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selected = "Week";

  final List<Map<String, dynamic>> options = [
    {"title": "Day"},
    {"title": "Week"},
    {"title": "Month"},
  ];
  final Map<String, List<double>> stressData = {
    "Day": [20, 40, 30, 50, 45, 60, 55],
    "Week": [20, 35, 60, 30, 20, 15, 25],
    "Month": [40, 50, 30, 70, 60, 50, 45],
  };

  final Map<String, List<double>> hrvData = {
    "Day": [65, 30, 45, 60, 75, 85, 80],
    "Week": [65, 30, 45, 60, 75, 85, 80], // Matched to visual trend in image
    "Month": [65, 30, 45, 60, 75, 85, 80],
  };

  final List<Map<String, dynamic>> insightsData = [
    {
      "title": "Peak Stress Timing",
      "description":
          "Your stress levels consistently peak around 2:00 PM on weekdays. Consider scheduling a short break.",
      "badge": "HIGH RISK",
    },
    {
      "title": "Sleep Impact",
      "description":
          "Poor sleep on Tuesday directly correlated with a 30% drop in your HRV on Wednesday.",
      "badge": "MEDIUM",
    },
    {
      "title": "Overall Assessment",
      "description":
          "You are managing stress well, but afternoon fatigue is a recurring pattern.",
    },
  ];

  List<String> get xLabels {
    return ["M", "T", "W", "T", "F", "S", "S"];
  }

  List<double> get currentStressData => stressData[selected]!;
  List<double> get currentHRVData => hrvData[selected]!;

  @override
  Widget build(BuildContext context) {
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

                // Title
                Center(
                  child: Text(
                    "AI Analysis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                UIHelper.verticalSpace(20.h),

                // Segmented Control (ListView.builder)
                Container(
                  height: 45.h,
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final item = options[index];
                      final title = item["title"];
                      final isActive = selected == title;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = title;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isActive
                                    ? const Color(0xFF3A3A3A)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
                                fontWeight:
                                    isActive
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                UIHelper.verticalSpace(30.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1C1C1E), Color(0xFF111113)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Stress Trend",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          /// Percentage badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A2F),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "-15%",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(20.h),

                      /// Chart
                      SizedBox(
                        height: 140.h,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),

                            /// X Axis Labels
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    if (value.toInt() >= xLabels.length ||
                                        value.toInt() < 0) {
                                      return const SizedBox();
                                    }

                                    return Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        xLabels[value.toInt()],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            /// Line
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                curveSmoothness: 0.4,
                                spots:
                                    currentStressData.asMap().entries.map((e) {
                                      return FlSpot(e.key.toDouble(), e.value);
                                    }).toList(),
                                color: Colors.deepOrangeAccent,
                                barWidth: 3,

                                /// ❌ remove dots
                                dotData: const FlDotData(show: false),

                                /// Gradient Fill
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepOrangeAccent.withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                            lineTouchData: LineTouchData(
                              enabled: true,
                              handleBuiltInTouches: true,
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipColor:
                                    (spot) => const Color(0xFF2A2A2A),
                                tooltipBorderRadius: BorderRadius.circular(8.r),
                                tooltipPadding: EdgeInsets.all(8.r),
                                getTooltipItems: (spots) {
                                  return spots.map((spot) {
                                    return LineTooltipItem(
                                      "${xLabels[spot.x.toInt()]}\nstress : ${spot.y.toInt()}%",
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.linear,
                        ),
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(20.h),

                /// HRV Variability Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HRV Variability",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      UIHelper.verticalSpace(30.h),
                      SizedBox(
                        height: 160.h,
                        child: BarChart(
                          BarChartData(
                            alignment:
                                BarChartAlignment
                                    .spaceBetween, // Better spacing for 7 bars
                            maxY: 100,
                            barTouchData: BarTouchData(
                              enabled: true,
                              handleBuiltInTouches: true,
                              touchExtraThreshold: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor:
                                    (group) => const Color(0xFF262626),
                                tooltipPadding: EdgeInsets.all(12.r),
                                tooltipBorderRadius: BorderRadius.circular(
                                  12.r,
                                ),
                                fitInsideHorizontally: true,
                                fitInsideVertically: true,
                                getTooltipItem: (
                                  group,
                                  groupIndex,
                                  rod,
                                  rodIndex,
                                ) {
                                  return BarTooltipItem(
                                    "${xLabels[groupIndex]}\n",
                                    TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "hrv : ${rod.toY.toInt()}",
                                        style: TextStyle(
                                          color: const Color(0xFF4CAF50),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    if (value.toInt() >= xLabels.length ||
                                        value.toInt() < 0) {
                                      return const SizedBox();
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 12.h),
                                      child: Text(
                                        xLabels[value.toInt()],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            barGroups:
                                currentHRVData.asMap().entries.map((e) {
                                  return BarChartGroupData(
                                    x: e.key,
                                    barRods: [
                                      BarChartRodData(
                                        toY: e.value,
                                        color: const Color(0xFF4CAF50),
                                        width: 16.w,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6.r),
                                          topRight: Radius.circular(6.r),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          ),
                          swapAnimationDuration: const Duration(
                            milliseconds: 250,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(30.h),

                /// Key Insights Section
                Text(
                  "Key Insights",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(20.h),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: insightsData.length,
                  itemBuilder: (context, index) {
                    final item = insightsData[index];

                    // Simple lists for styles (colors, icons) to avoid complex conditions
                    final colors = [
                      const Color(0xFFFFC107),
                      const Color(0xFF4CAF50),
                      const Color(0xFFFF7043),
                    ];
                    final bgColors = [
                      const Color(0xFF2C2415),
                      const Color(0xFF1A2B20),
                      Colors.transparent,
                    ];
                    final icons = [
                      Icons.access_time_filled_rounded,
                      Icons.nightlight_round,
                      Icons.psychology_rounded,
                    ];
                    final badgeBgs = [
                      const Color(0xFF3B1F1F),
                      const Color(0xFF2C2515),
                      Colors.transparent,
                    ];
                    final badgeTextColors = [
                      const Color(0xFFFF5252),
                      const Color(0xFFFFC107),
                      Colors.transparent,
                    ];

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(24.r),
                        border:
                            index == 2
                                ? Border.all(
                                  color: const Color(0xFF3D2B1F),
                                  width: 1.5,
                                )
                                : null,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.r),
                                decoration: BoxDecoration(
                                  color: bgColors[index],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  icons[index],
                                  color: colors[index],
                                  size: index == 2 ? 30.r : 24.r,
                                ),
                              ),
                              UIHelper.horizontalSpace(16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    UIHelper.verticalSpace(8.h),
                                    Text(
                                      item["description"],
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.sp,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (item["badge"] != null)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: badgeBgs[index],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  item["badge"],
                                  style: TextStyle(
                                    color: badgeTextColors[index],
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
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
