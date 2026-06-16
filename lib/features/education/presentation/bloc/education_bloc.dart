import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/education_model.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'education_event.dart';
part 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  EducationBloc() : super(const EducationInitial()) {
    on<LoadEducationData>(_onLoadEducationData);
    on<ViewMarksheet>(_onViewMarksheet);
  }

  final List<EducationModel> _educations = const [
    EducationModel(
      id: '1',
      level: 'btech',
      instituteName: 'CGC Jhanjeri',
      board: 'Punjab Technical University (PTU)',
      year: '2022 – Present',
      cgpa: '7.8',
      currentSemester: '7th Semester',
      currentYear: '4th Year',
      description:
          'Bachelor of Technology in Computer Science Engineering. Specializing in software development, data structures, algorithms, and mobile application development.',
    ),
    EducationModel(
      id: '2',
      level: '12th',
      instituteName: 'Asha modern international school',
      board: 'CBSE',
      year: '2021 – 2022',
      percentage: '76%',
      description:
          'Completed Class 12 with Science stream (PCM). Achieved excellent results with strong foundation in Mathematics.',
    ),
    EducationModel(
      id: '3',
      level: '10th',
      instituteName: 'Asha modern international school',
      board: 'CBSE',
      year: '2019 – 2020',
      percentage: '84.4%',
      description:
          'Completed Class 10 with distinction. Strong performance across all subjects with particular aptitude in Mathematics and Science.',
    ),
  ];

  Future<void> _onLoadEducationData(
      LoadEducationData event, Emitter<EducationState> emit) async {
    emit(const EducationLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(EducationLoaded(_educations));
  }

  Future<void> _onViewMarksheet(
      ViewMarksheet event, Emitter<EducationState> emit) async {
    await UrlLauncherUtils.openUrl(event.url);
  }
}
