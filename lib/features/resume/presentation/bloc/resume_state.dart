part of 'resume_bloc.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();
  @override
  List<Object?> get props => [];
}

class ResumeInitial extends ResumeState {
  const ResumeInitial();
}

class ResumeLoading extends ResumeState {
  const ResumeLoading();
}

class ResumeLoaded extends ResumeState {
  final String resumeUrl;
  const ResumeLoaded(this.resumeUrl);
  @override
  List<Object?> get props => [resumeUrl];
}

class ResumeError extends ResumeState {
  final String message;
  const ResumeError(this.message);
  @override
  List<Object?> get props => [message];
}
