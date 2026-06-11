part of 'skills_bloc.dart';

abstract class SkillsEvent extends Equatable {
  const SkillsEvent();
  @override
  List<Object?> get props => [];
}

class LoadSkills extends SkillsEvent {
  const LoadSkills();
}
