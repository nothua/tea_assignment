import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tea_assignment/core/constants/app_colors.dart';
import 'package:tea_assignment/core/constants/app_dimensions.dart';
import 'package:tea_assignment/features/daily_metrics/widgets/daily_metrics_chart.dart';
import 'package:tea_assignment/features/daily_metrics/widgets/metric_row.dart';

class DailyMetricsScreen extends StatelessWidget {
  const DailyMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding24, 
            vertical: AppDimensions.spacing20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily metrics',
                    style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: AppDimensions.dailyMetricsTitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: AppDimensions.iconSize24, 
                    color: AppColors.grey8E,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.spacing32),
              // Content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chart
                  Expanded(
                    child: Center(
                      child: DailyMetricsChart(
                        outerData: [
                          DailyMetricData(
                            display: 'Sleep',
                            value: '08:00',
                            progress: 8 / 24,
                            color: AppColors.metricSleep,
                          ),
                          DailyMetricData(
                            display: 'Plan',
                            value: '09:30',
                            progress: 9.5 / 24,
                            color: AppColors.metricPlan,
                          ),
                          DailyMetricData(
                            display: 'Open',
                            value: '06:30',
                            progress: 6.5 / 24,
                            color: AppColors.metricOpen,
                          ),
                        ],
                        innerData: [
                          DailyMetricData(
                            display: 'In Progress',
                            value: '01:10',
                            progress: 0.02,
                            color: AppColors.metricPlan,
                          ),
                          DailyMetricData(
                            display: 'Done',
                            value: '04:15',
                            progress: 0.5,
                            color: AppColors.metricDone,
                          ),
                          DailyMetricData(
                            display: 'Canceled',
                            value: '00:00',
                            progress: 0.05,
                            color: AppColors.metricCanceled,
                          ),
                          DailyMetricData(
                            display: 'Overdue',
                            value: '00:00',
                            progress: 0.2,
                            color: AppColors.metricOverdue,
                          ),
                          DailyMetricData(
                            display: 'Moved',
                            value: '00:00',
                            progress: 0.15,
                            color: AppColors.metricMoved,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.spacing20),
                  // Metrics List
                  Expanded(
                    child: Column(
                      children: [
                        MetricRow(
                          label: 'In Progress',
                          time: '01:10',
                          percentage: '0.0%',
                          color: AppColors.metricPlan,
                          progress: 0.1,
                        ),
                        MetricRow(
                          label: 'Done',
                          time: '04:15',
                          percentage: '50%',
                          color: AppColors.metricDone,
                          progress: 0.5,
                        ),
                        MetricRow(
                          label: 'Canceled',
                          time: '00:00',
                          percentage: '0.0%',
                          color: AppColors.metricCanceled,
                          progress: 0.05,
                        ),
                        MetricRow(
                          label: 'Overdue',
                          time: '00:00',
                          percentage: '0.0%',
                          color: AppColors.metricOverdue,
                          progress: 0.2,
                        ),
                        MetricRow(
                          label: 'Moved',
                          time: '00:00',
                          percentage: '0.0%',
                          color: AppColors.metricMoved,
                          progress: 0.15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
