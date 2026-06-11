import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const AboutInitial()) {
    on<LoadAboutData>(_onLoadAboutData);
  }

  Future<void> _onLoadAboutData(
      LoadAboutData event, Emitter<AboutState> emit) async {
    emit(const AboutLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(AboutLoaded(
      about: AppConstants.aboutText,
      objective: AppConstants.careerObjective,
      college: AppConstants.college,
      currentYear: AppConstants.currentYear,
      currentSemester: AppConstants.currentSemester,
    ));
  }
}
