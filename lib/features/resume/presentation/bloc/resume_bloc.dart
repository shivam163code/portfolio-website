import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'resume_event.dart';
part 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(const ResumeInitial()) {
    on<LoadResume>(_onLoadResume);
    on<DownloadResume>(_onDownloadResume);
    on<OpenResume>(_onOpenResume);
  }

  Future<void> _onLoadResume(
      LoadResume event, Emitter<ResumeState> emit) async {
    emit(const ResumeLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(const ResumeLoaded(AppConstants.resumeUrl));
  }

  Future<void> _onDownloadResume(
      DownloadResume event, Emitter<ResumeState> emit) async {
    await UrlLauncherUtils.openUrl(AppConstants.resumeUrl);
  }

  Future<void> _onOpenResume(
      OpenResume event, Emitter<ResumeState> emit) async {
    await UrlLauncherUtils.openUrl(AppConstants.resumeUrl);
  }
}
