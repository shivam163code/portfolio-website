import 'package:equatable/equatable.dart';

class EducationModel extends Equatable {
  final String id;
  final String level; // '10th', '12th', 'btech'
  final String instituteName;
  final String board;
  final String year;
  final String? percentage;
  final String? cgpa;
  final String? currentSemester;
  final String? currentYear;
  final String? marksheetUrl;
  final String description;

  const EducationModel({
    required this.id,
    required this.level,
    required this.instituteName,
    required this.board,
    required this.year,
    this.percentage,
    this.cgpa,
    this.currentSemester,
    this.currentYear,
    this.marksheetUrl,
    required this.description,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        id: json['id'] as String,
        level: json['level'] as String,
        instituteName: json['instituteName'] as String,
        board: json['board'] as String,
        year: json['year'] as String,
        percentage: json['percentage'] as String?,
        cgpa: json['cgpa'] as String?,
        currentSemester: json['currentSemester'] as String?,
        currentYear: json['currentYear'] as String?,
        marksheetUrl: json['marksheetUrl'] as String?,
        description: json['description'] as String,
      );

  @override
  List<Object?> get props => [id, level, instituteName, board, year];
}
