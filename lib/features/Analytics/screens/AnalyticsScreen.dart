import 'package:docdoc_app/features/Analytics/cubit/AnalyticsCubit.dart';
import 'package:docdoc_app/features/Analytics/cubit/AnalyticsState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class WeeklyMoodScreen extends StatelessWidget {
  const WeeklyMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<WeeklyMoodCubit>()..fetchWeeklyMood(),
      child: Scaffold(
        appBar: AppBar(title: const Text("تحليل الأسبوع")),
        body: BlocBuilder<WeeklyMoodCubit, WeeklyMoodState>(
          builder: (context, state) {
            if (state is WeeklyMoodLoading) {
              return _buildShimmer();
            } else if (state is WeeklyMoodLoaded) {
              final data = state.data;
              final dailyData = data.dailyData;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      "من ${DateFormat.yMMMd().format(data.weekStartDate)} إلى ${DateFormat.yMMMd().format(data.weekEndDate)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, _) {
                                  int index = value.toInt();
                                  if (index < 0 || index >= dailyData.length) {
                                    return const SizedBox();
                                  }
                                  final date = DateFormat(
                                    'E',
                                  ).format(dailyData[index].date);
                                  return Text(date);
                                },
                              ),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              spots:
                                  dailyData.asMap().entries.map((e) {
                                    return FlSpot(
                                      e.key.toDouble(),
                                      e.value.averageIntensity.toDouble(),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "التحليل الأسبوعي",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "الشعور السائد: ${data.summary.dominantEmotion}",
                            ),
                            Text(
                              "متوسط الشدة: ${data.summary.averageIntensity}",
                            ),
                            Text(
                              "عدد الأيام المستقرة: ${data.summary.consistentDays}",
                            ),
                            Text(
                              "المشاعر الفريدة: ${data.summary.uniqueEmotions}",
                            ),
                            Text(
                              "مجموع السجلات: ${data.summary.totalMoodRecords}",
                            ),
                            Text(
                              "السكور العام: ${data.summary.weeklyScore.toStringAsFixed(2)}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          data.comparison.changeDirection == "worse"
                              ? Icons.trending_down
                              : Icons.trending_up,
                          color:
                              data.comparison.changeDirection == "worse"
                                  ? Colors.red
                                  : Colors.green,
                        ),
                        title: const Text("مقارنة بالأسبوع الماضي"),
                        subtitle: Text(
                          "الفرق: ${data.comparison.changePercentage.toStringAsFixed(1)}%",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WeeklyMoodError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder:
          (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade600,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 100),
            ),
          ),
    );
  }
}
