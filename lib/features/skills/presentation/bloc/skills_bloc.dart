import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'skills_event.dart';
part 'skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {
  SkillsBloc() : super(const SkillsInitial()) {
    on<LoadSkills>(_onLoadSkills);
  }

  Future<void> _onLoadSkills(
      LoadSkills event, Emitter<SkillsState> emit) async {
    emit(const SkillsLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final categories = [
      const SkillCategory(
        id: 'flutter',
        name: 'Flutter Development',
        icon: 'flutter',
        color: '#54C5F8',
        skills: [
          SkillItem(name: 'Flutter', percentage: 90),
          SkillItem(name: 'Dart', percentage: 88),
          SkillItem(name: 'BLoC Pattern', percentage: 82),
          SkillItem(name: 'Flutter Web', percentage: 78),
        ],
      ),
      const SkillCategory(
        id: 'languages',
        name: 'Programming Languages',
        icon: 'code',
        color: '#6C63FF',
        skills: [
          SkillItem(name: 'Dart', percentage: 88),
          SkillItem(name: 'Python', percentage: 75),
          SkillItem(name: 'Java', percentage: 70),
          SkillItem(name: 'JavaScript', percentage: 60),
        ],
      ),
      const SkillCategory(
        id: 'web',
        name: 'Web Development',
        icon: 'web',
        color: '#E44D26',
        skills: [
          SkillItem(name: 'HTML', percentage: 80),
          SkillItem(name: 'CSS', percentage: 75),
          SkillItem(name: 'Flutter Web', percentage: 78),
        ],
      ),
      const SkillCategory(
        id: 'database',
        name: 'Database & Backend',
        icon: 'database',
        color: '#4DB33D',
        skills: [
          SkillItem(name: 'Firebase', percentage: 82),
          SkillItem(name: 'MongoDB', percentage: 68),
          SkillItem(name: 'REST APIs', percentage: 78),
        ],
      ),
      const SkillCategory(
        id: 'tools',
        name: 'Tools & Platforms',
        icon: 'tools',
        color: '#F05032',
        skills: [
          SkillItem(name: 'Git', percentage: 85),
          SkillItem(name: 'GitHub', percentage: 85),
          SkillItem(name: 'VS Code', percentage: 90),
          SkillItem(name: 'Android Studio', percentage: 80),
        ],
      ),
    ];

    emit(SkillsLoaded(categories));
  }
}
