part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();
  @override
  List<Object?> get props => [];
}

class AboutInitial extends AboutState {
  const AboutInitial();
}

class AboutLoading extends AboutState {
  const AboutLoading();
}

class AboutLoaded extends AboutState {
  final String about;
  final String objective;
  final String college;
  final String currentYear;
  final String currentSemester;
  const AboutLoaded({
    required this.about,
    required this.objective,
    required this.college,
    required this.currentYear,
    required this.currentSemester,
  });
  @override
  List<Object?> get props => [about, objective, college];
}

class AboutError extends AboutState {
  final String message;
  const AboutError(this.message);
  @override
  List<Object?> get props => [message];
}
