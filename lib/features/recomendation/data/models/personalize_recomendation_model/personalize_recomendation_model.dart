import 'package:equatable/equatable.dart';

class PersonalizeRecomendationModel extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? type;
  final String? category;
  final List<String> targetEmotions;
  final String? instructions;
  final int? estimatedDurationMinutes;
  final String? difficultyLevel;
  final double? effectivenessRating;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PersonalizeRecomendationModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.category,
    required this.targetEmotions,
    this.instructions,
    this.estimatedDurationMinutes,
    this.difficultyLevel,
    this.effectivenessRating,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PersonalizeRecomendationModel.fromJson(Map<String, dynamic> json) {
    return PersonalizeRecomendationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      targetEmotions:
          (json['targetEmotions'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),

      instructions: json['instructions'] as String?,
      estimatedDurationMinutes: json['estimatedDurationMinutes'] as int?,
      difficultyLevel: json['difficultyLevel'] as String?,
      effectivenessRating: (json['effectivenessRating'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'type': type,
    'category': category,
    'targetEmotions': targetEmotions,
    'instructions': instructions,
    'estimatedDurationMinutes': estimatedDurationMinutes,
    'difficultyLevel': difficultyLevel,
    'effectivenessRating': effectivenessRating,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      type,
      category,
      targetEmotions,
      instructions,
      estimatedDurationMinutes,
      difficultyLevel,
      effectivenessRating,
      isActive,
      createdAt,
      updatedAt,
    ];
  }
}
