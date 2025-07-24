class MoodRecord {
  final int id;
  final int userId;
  final String emotionType;
  final int intensityLevel;
  final String? notes;
  final String detectionMethod;
  final DateTime recordedAt;
  final DateTime createdAt;
  final double? facialConfidenceScore;
  final double? voiceConfidenceScore;
  final String? location;
  final String? weatherCondition;

  MoodRecord({
    required this.id,
    required this.userId,
    required this.emotionType,
    required this.intensityLevel,
    required this.notes,
    required this.detectionMethod,
    required this.recordedAt,
    required this.createdAt,
    this.facialConfidenceScore,
    this.voiceConfidenceScore,
    this.location,
    this.weatherCondition,
  });

  factory MoodRecord.fromJson(Map<String, dynamic> json) {
    return MoodRecord(
      id: json['id'],
      userId: json['userId'],
      emotionType: json['emotionType'],
      intensityLevel: json['intensityLevel'],
      notes: json['notes'],
      detectionMethod: json['detectionMethod'],
      recordedAt: DateTime.parse(json['recordedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      facialConfidenceScore: json['facialConfidenceScore']?.toDouble(),
      voiceConfidenceScore: json['voiceConfidenceScore']?.toDouble(),
      location: json['location'],
      weatherCondition: json['weatherCondition'],
    );
  }
}

class MoodHistoryResponse {
  final List<MoodRecord> records;
  final int totalRecords;
  final DateTime firstRecordDate;
  final DateTime lastRecordDate;
  final String mostCommonEmotion;
  final double averageIntensity;

  MoodHistoryResponse({
    required this.records,
    required this.totalRecords,
    required this.firstRecordDate,
    required this.lastRecordDate,
    required this.mostCommonEmotion,
    required this.averageIntensity,
  });

  factory MoodHistoryResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return MoodHistoryResponse(
      records: List<MoodRecord>.from(data['records'].map((e) => MoodRecord.fromJson(e))),
      totalRecords: data['totalRecords'],
      firstRecordDate: DateTime.parse(data['firstRecordDate']),
      lastRecordDate: DateTime.parse(data['lastRecordDate']),
      mostCommonEmotion: data['mostCommonEmotion'],
      averageIntensity: (data['averageIntensity'] as num).toDouble(),
    );
  }
}
