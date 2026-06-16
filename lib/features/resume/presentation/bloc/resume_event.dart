part of 'resume_bloc.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();
  @override
  List<Object?> get props => [];
}

class LoadResume extends ResumeEvent {
  const LoadResume();
}

class DownloadResume extends ResumeEvent {
  const DownloadResume();
}

class OpenResume extends ResumeEvent {
  const OpenResume();
}
