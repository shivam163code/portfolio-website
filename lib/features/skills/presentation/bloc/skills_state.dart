part of 'skills_bloc.dart';

abstract class SkillsState extends Equatable {
  const SkillsState();
  @override
  List<Object?> get props => [];
}

class SkillsInitial extends SkillsState {
  const SkillsInitial();
}

class SkillsLoading extends SkillsState {
  const SkillsLoading();
}

class SkillsLoaded extends SkillsState {
  final List<SkillCategory> categories;
  const SkillsLoaded(this.categories);
  @override
  List<Object?> get props => [categories];
}

class SkillsError extends SkillsState {
  final String message;
  const SkillsError(this.message);
  @override
  List<Object?> get props => [message];
}

class SkillCategory {
  final String id;
  final String name;
  final String icon;
  final String color;
  final List<SkillItem> skills;
  const SkillCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.skills,
  });
}

class SkillItem {
  final String name;
  final int percentage;
  const SkillItem({required this.name, required this.percentage});
}
