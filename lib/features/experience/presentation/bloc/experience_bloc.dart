import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/experience_model.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc() : super(const ExperienceInitial()) {
    on<LoadExperienceData>(_onLoadExperienceData);
  }

  final List<ExperienceModel> _experiences = const [
    ExperienceModel(
      id: '1',
      title: 'Home Tutor',
      company: 'Self-Employed',
      duration: 'Jan 2022 – Present',
      type: 'Part-time',
      responsibilities: [
        'Teaching Mathematics, Science & CS to Classes 1–10',
        'Creating customized study plans for each student',
        'Conducting regular assessments and progress tracking',
        'Preparing students for board exams with focused revision',
        'Providing academic and career guidance',
      ],
      skills: ['Teaching', 'Communication', 'Problem Solving', 'Mentoring'],
      isCurrent: true,
    ),
    ExperienceModel(
      id: '2',
      title: 'Mathematics Teacher',
      company: 'Private Coaching Centre',
      duration: 'Jun 2022 – Dec 2022',
      type: 'Part-time',
      responsibilities: [
        'Taught Mathematics to Classes 6–10 students',
        'Developed engaging lesson plans and teaching materials',
        'Conducted weekly doubt-clearing sessions',
        'Improved student pass rates significantly',
      ],
      skills: ['Mathematics', 'Teaching', 'Curriculum Design'],
      isCurrent: false,
    ),
    ExperienceModel(
      id: '3',
      title: 'Science Teacher',
      company: 'Community Learning Center',
      duration: 'Apr 2021 – May 2022',
      type: 'Volunteer',
      responsibilities: [
        'Taught Science to underprivileged students in Classes 5–8',
        'Used innovative methods to make science engaging',
        'Organized practical experiments and activities',
        'Contributed to improving community learning outcomes',
      ],
      skills: ['Science', 'Teaching', 'Community Service', 'Innovation'],
      isCurrent: false,
    ),
  ];

  Future<void> _onLoadExperienceData(
      LoadExperienceData event, Emitter<ExperienceState> emit) async {
    emit(const ExperienceLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(ExperienceLoaded(_experiences));
  }
}
