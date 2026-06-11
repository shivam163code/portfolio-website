part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();
  @override
  List<Object?> get props => [];
}

class LoadProjects extends ProjectsEvent {
  const LoadProjects();
}

class FilterProjects extends ProjectsEvent {
  final String category;
  const FilterProjects(this.category);
  @override
  List<Object?> get props => [category];
}

class OpenGithub extends ProjectsEvent {
  final String url;
  const OpenGithub(this.url);
  @override
  List<Object?> get props => [url];
}

class OpenLiveDemo extends ProjectsEvent {
  final String url;
  const OpenLiveDemo(this.url);
  @override
  List<Object?> get props => [url];
}
