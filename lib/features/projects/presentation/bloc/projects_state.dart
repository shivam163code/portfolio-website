part of 'projects_bloc.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();
  @override
  List<Object?> get props => [];
}

class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectModel> projects;
  final List<ProjectModel> filteredProjects;
  final String activeFilter;
  const ProjectsLoaded({
    required this.projects,
    required this.filteredProjects,
    required this.activeFilter,
  });
  @override
  List<Object?> get props => [projects, filteredProjects, activeFilter];
}

class ProjectsError extends ProjectsState {
  final String message;
  const ProjectsError(this.message);
  @override
  List<Object?> get props => [message];
}
