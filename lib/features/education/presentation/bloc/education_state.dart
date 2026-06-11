part of 'education_bloc.dart';

abstract class EducationState extends Equatable {
  const EducationState();
  @override
  List<Object?> get props => [];
}

class EducationInitial extends EducationState {
  const EducationInitial();
}

class EducationLoading extends EducationState {
  const EducationLoading();
}

class EducationLoaded extends EducationState {
  final List<EducationModel> educations;
  const EducationLoaded(this.educations);
  @override
  List<Object?> get props => [educations];
}

class EducationError extends EducationState {
  final String message;
  const EducationError(this.message);
  @override
  List<Object?> get props => [message];
}
