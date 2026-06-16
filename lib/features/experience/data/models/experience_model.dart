import 'package:equatable/equatable.dart';

class ExperienceModel extends Equatable {
  final String id;
  final String title;
  final String company;
  final String duration;
  final String type; // 'Part-time', 'Full-time', 'Freelance'
  final List<String> responsibilities;
  final List<String> skills;
  final bool isCurrent;

  const ExperienceModel({
    required this.id,
    required this.title,
    required this.company,
    required this.duration,
    required this.type,
    required this.responsibilities,
    required this.skills,
    this.isCurrent = false,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      ExperienceModel(
        id: json['id'] as String,
        title: json['title'] as String,
        company: json['company'] as String,
        duration: json['duration'] as String,
        type: json['type'] as String,
        responsibilities: List<String>.from(json['responsibilities'] as List),
        skills: List<String>.from(json['skills'] as List),
        isCurrent: (json['isCurrent'] as bool?) ?? false,
      );

  @override
  List<Object?> get props => [id, title, company, duration];
}
