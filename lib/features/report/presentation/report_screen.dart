import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedTab = 0; // 0: Week, 1: Month, 2: Year
  int touchedIndex = -1;

  // Simple dummy list for easy API integration later
  final List<Map<String, dynamic>> _reports = [
    {
      'overallScore': 45,
      'overallStatus': 'Good',
      'lowStress': 60.0,
      'moderateStress': 25.0,
      'highStress': 15.0,
      'avgBpm': 72,
      'avgHrv': 48,
      'totalSessions': 14,
      'trend': const [
        FlSpot(0, 2),
        FlSpot(1, 2.5),
        FlSpot(2, 4.2),
        FlSpot(3, 3.8),
        FlSpot(4, 2.0),
        FlSpot(5, 1.4),
        FlSpot(6, 1.0),
      ],
    },
    {
      'overallScore': 72,
      'overallStatus': 'Moderate',
      'lowStress': 40.0,
      'moderateStress': 40.0,
      'highStress': 20.0,
      'avgBpm': 85,
      'avgHrv': 32,
      'totalSessions': 21,
      'trend': const [
        FlSpot(0, 1),
        FlSpot(1, 1.5),
        FlSpot(2, 2.8),
        FlSpot(3, 3.2),
        FlSpot(4, 4.0),
        FlSpot(5, 3.5),
        FlSpot(6, 2.0),
      ],
    },
    {
      'overallScore': 30,
      'overallStatus': 'Excellent',
      'lowStress': 80.0,
      'moderateStress': 15.0,
      'highStress': 5.0,
      'avgBpm': 65,
      'avgHrv': 55,
      'totalSessions': 8,
      'trend': const [
        FlSpot(0, 4),
        FlSpot(1, 3.5),
        FlSpot(2, 2.2),
        FlSpot(3, 1.8),
        FlSpot(4, 3.0),
        FlSpot(5, 4.4),
        FlSpot(6, 5.0),
      ],
    },
  ];

  Map<String, dynamic> get currentReport => _reports[selectedTab];

  List<Map<String, dynamic>> get statsData => [
    {
      'icon': Icons.favorite_rounded,
      'color': Colors.redAccent,
      'label': 'Avg BPM',
      'value': '${currentReport['avgBpm'] ?? 0}',
      'unit': null,
    },
    {
      'icon': Icons.timeline_rounded,
      'color': Colors.greenAccent,
      'label': 'Avg HRV',
      'value': '${currentReport['avgHrv'] ?? 0}',
      'unit': ' ms',
    },
    {
      'icon': Icons.access_time_filled_rounded,
      'color': Colors.amber,
      'label': 'Total Sessions',
      'value': '${currentReport['totalSessions'] ?? 0}',
      'unit': null,
    },
    {
      'icon': Icons.psychology_rounded,
      'color': Colors.deepOrangeAccent,
      'label': 'Avg Stress',
      'value': '${currentReport['overallScore'] ?? 0}',
      'unit': ' /100',
    },
  ];

  List<Map<String, dynamic>> get stressDistribution => [
    {
      'color': AppColors.c22C55E,
      'label': 'Low Stress',
      'percent': (currentReport['lowStress'] ?? 0.0) as double,
    },
    {
      'color': const Color(0xFFFFC107),
      'label': 'Moderate',
      'percent': (currentReport['moderateStress'] ?? 0.0) as double,
    },
    {
      'color': AppColors.cEF4444,
      'label': 'High Stress',
      'percent': (currentReport['highStress'] ?? 0.0) as double,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UIHelper.verticalSpace(20.h),
              _buildOverallBadge(),
              UIHelper.verticalSpace(30.h),
              _buildTabBar(),
              UIHelper.verticalSpace(30.h),
              _buildStressTrendCard(),
              UIHelper.verticalSpace(20.h),
              _buildStressDistributionCard(),
              UIHelper.verticalSpace(20.h),
              _buildStatsGrid(),
              UIHelper.verticalSpace(40.h),
              _buildActionButtons(),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.c18181B,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.c3F464C.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: const BoxDecoration(
              color: AppColors.c22C55E,
              shape: BoxShape.circle,
            ),
          ),
          UIHelper.horizontalSpace(8.w),
          Text(
            'Overall: ${currentReport['overallScore'] ?? 0}/100 — ${currentReport['overallStatus'] ?? 'Unknown'}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.c18181B,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _buildTab(0, 'Week'),
          _buildTab(1, 'Month'),
          _buildTab(2, 'Year'),
        ],
      ),
    );
  }

  Widget _buildStressTrendCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.c27272A,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stress Trend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          UIHelper.verticalSpace(30.h),
          SizedBox(height: 150.h, child: LineChart(_mainData())),
        ],
      ),
    );
  }

  Widget _buildStressDistributionCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.c27272A,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stress Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          UIHelper.verticalSpace(20.h),
          Row(
            children: [
              _buildPieChart(),
              UIHelper.horizontalSpace(20.w),
              _buildDistributionLegend(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.4,
      ),
      itemCount: statsData.length,
      itemBuilder: (context, index) {
        final item = statsData[index];
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.c18181B,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 24.sp,
              ),
              const Spacer(),
              Text(
                item['label'] as String,
                style: TextStyle(color: AppColors.c8B8A8C, fontSize: 13.sp),
              ),
              UIHelper.verticalSpace(4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    item['value'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (item['unit'] != null)
                    Text(
                      item['unit'] as String,
                      style: TextStyle(
                        color: AppColors.c8B8A8C,
                        fontSize: 13.sp,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              color: AppColors.c18181B,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.share_rounded, color: Colors.white, size: 20.sp),
                UIHelper.horizontalSpace(8.w),
                Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        UIHelper.horizontalSpace(16.w),
        Expanded(
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              color: AppColors.cFF5722,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download_rounded, color: Colors.white, size: 20.sp),
                UIHelper.horizontalSpace(8.w),
                Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 120.h,
      width: 120.h,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 36.r,
          startDegreeOffset: 180,
          sections:
              stressDistribution.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isTouched = index == touchedIndex;
                return PieChartSectionData(
                  color: item['color'] as Color,
                  value: item['percent'] as double,
                  title: '',
                  radius: isTouched ? 22.r : 18.r,
                  badgeWidget:
                      isTouched
                          ? _buildPieBadge(
                            item['label'],
                            (item['percent'] as double).toInt(),
                          )
                          : null,
                  badgePositionPercentageOffset: 2.2,
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildPieBadge(String label, int percent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.c27272A,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 4),
        ],
      ),
      child: Text(
        '$label : $percent',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDistributionLegend() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stressDistribution.length,
        itemBuilder: (context, index) {
          final item = stressDistribution[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == stressDistribution.length - 1 ? 0 : 12.h,
            ),
            child: _buildLegendItem(
              item['color'] as Color,
              item['label'] as String,
              '${(item['percent'] as double).toInt()}%',
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.c3F464C : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.cA7A8AC,
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String percentage) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        UIHelper.horizontalSpace(8.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: AppColors.cE6E6E6, fontSize: 14.sp),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: (currentReport['trend'] ?? const <FlSpot>[]) as List<FlSpot>,
          isCurved: true,
          color: AppColors.cFF5A2C,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
