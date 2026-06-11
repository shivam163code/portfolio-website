import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final List<String> technologies;
  final String githubUrl;
  final String? liveDemoUrl;
  final String imageUrl;
  final String category;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.technologies,
    required this.githubUrl,
    this.liveDemoUrl,
    required this.imageUrl,
    required this.category,
    this.isFeatured = false,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        shortDescription: json['shortDescription'] as String,
        technologies: List<String>.from(json['technologies'] as List),
        githubUrl: json['githubUrl'] as String,
        liveDemoUrl: json['liveDemoUrl'] as String?,
        imageUrl: json['imageUrl'] as String,
        category: json['category'] as String,
        isFeatured: (json['isFeatured'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'shortDescription': shortDescription,
        'technologies': technologies,
        'githubUrl': githubUrl,
        'liveDemoUrl': liveDemoUrl,
        'imageUrl': imageUrl,
        'category': category,
        'isFeatured': isFeatured,
      };

  @override
  List<Object?> get props => [id, name, description, technologies, githubUrl, liveDemoUrl, imageUrl, category, isFeatured];
}
