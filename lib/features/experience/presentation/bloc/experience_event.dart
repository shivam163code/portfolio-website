part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();
  @override
  List<Object?> get props => [];
}

class LoadExperienceData extends ExperienceEvent {
  const LoadExperienceData();
}
