part of 'experience_bloc.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();
  @override
  List<Object?> get props => [];
}

class ExperienceInitial extends ExperienceState {
  const ExperienceInitial();
}

class ExperienceLoading extends ExperienceState {
  const ExperienceLoading();
}

class ExperienceLoaded extends ExperienceState {
  final List<ExperienceModel> experiences;
  const ExperienceLoaded(this.experiences);
  @override
  List<Object?> get props => [experiences];
}

class ExperienceError extends ExperienceState {
  final String message;
  const ExperienceError(this.message);
  @override
  List<Object?> get props => [message];
}
