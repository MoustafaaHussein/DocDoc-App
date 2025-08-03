class WeeklyMoodModel {
  final DateTime weekStartDate;
  final DateTime weekEndDate;
  final List<DailyMoodData> dailyData;
  final MoodSummary summary;
  final MoodComparison comparison;

  WeeklyMoodModel({
    required this.weekStartDate,
    required this.weekEndDate,
    required this.dailyData,
    required this.summary,
    required this.comparison,
  });

  factory WeeklyMoodModel.fromJson(Map<String, dynamic> json) {
    return WeeklyMoodModel(
      weekStartDate: DateTime.parse(json['weekStartDate']),
      weekEndDate: DateTime.parse(json['weekEndDate']),
      dailyData:
          (json['dailyData'] as List)
              .map((e) => DailyMoodData.fromJson(e as Map<String, dynamic>))
              .toList(),
      summary: MoodSummary.fromJson(json['summary']),
      comparison: MoodComparison.fromJson(json['comparison']),
    );
  }
}

class DailyMoodData {
  final DateTime date;
  final String dominantEmotion;
  final double averageIntensity;
  final int totalRecords;
  final List<String> emotionsRecorded;

  DailyMoodData({
    required this.date,
    required this.dominantEmotion,
    required this.averageIntensity,
    required this.totalRecords,
    required this.emotionsRecorded,
  });

  factory DailyMoodData.fromJson(Map<String, dynamic> json) => DailyMoodData(
    date: DateTime.parse(json['date']),
    dominantEmotion: json['dominantEmotion'],
    averageIntensity: (json['averageIntensity'] as num).toDouble(),
    totalRecords: json['totalRecords'],
    emotionsRecorded: List<String>.from(json['emotionsRecorded']),
  );
}

class MoodSummary {
  final String dominantEmotion;
  final double averageIntensity;
  final int totalMoodRecords;
  final int uniqueEmotions;
  final int consistentDays;
  final double weeklyScore;

  MoodSummary({
    required this.dominantEmotion,
    required this.averageIntensity,
    required this.totalMoodRecords,
    required this.uniqueEmotions,
    required this.consistentDays,
    required this.weeklyScore,
  });

  factory MoodSummary.fromJson(Map<String, dynamic> json) => MoodSummary(
    dominantEmotion: json['dominantEmotion'],
    averageIntensity: (json['averageIntensity'] as num).toDouble(),
    totalMoodRecords: json['totalMoodRecords'],
    uniqueEmotions: json['uniqueEmotions'],
    consistentDays: json['consistentDays'],
    weeklyScore: (json['weeklyScore'] as num).toDouble(),
  );
}

class MoodComparison {
  final double previousWeekScore;
  final double changePercentage;
  final String changeDirection;

  MoodComparison({
    required this.previousWeekScore,
    required this.changePercentage,
    required this.changeDirection,
  });

  factory MoodComparison.fromJson(Map<String, dynamic> json) => MoodComparison(
    previousWeekScore: (json['previousWeekScore'] as num).toDouble(),
    changePercentage: (json['changePercentage'] as num).toDouble(),
    changeDirection: json['changeDirection'],
  );
}
