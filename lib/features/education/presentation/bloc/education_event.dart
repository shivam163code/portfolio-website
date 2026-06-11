part of 'education_bloc.dart';

abstract class EducationEvent extends Equatable {
  const EducationEvent();
  @override
  List<Object?> get props => [];
}

class LoadEducationData extends EducationEvent {
  const LoadEducationData();
}

class ViewMarksheet extends EducationEvent {
  final String url;
  const ViewMarksheet(this.url);
  @override
  List<Object?> get props => [url];
}
