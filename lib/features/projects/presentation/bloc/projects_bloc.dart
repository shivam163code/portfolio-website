import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/project_model.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(const ProjectsInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<FilterProjects>(_onFilterProjects);
    on<OpenGithub>(_onOpenGithub);
    on<OpenLiveDemo>(_onOpenLiveDemo);
  }

  final List<ProjectModel> _allProjects = const [
    ProjectModel(
      id: '1',
      name: 'E-Waste Facility Locator',
      description:
          'A Flutter mobile application that helps users locate nearby e-waste recycling facilities. Features GPS-based location, interactive map, facility details, directions, and user reviews.',
      shortDescription: 'Locate nearby e-waste recycling facilities with GPS and interactive maps.',
      technologies: ['Flutter', 'Dart', 'Google Maps', 'Firebase'],
      githubUrl: 'https://github.com/shivamkumar/ewaste-locator',
      imageUrl: 'https://via.placeholder.com/400x250/6C63FF/FFFFFF?text=E-Waste+Locator',
      category: 'Mobile App',
      isFeatured: true,
    ),
    ProjectModel(
      id: '2',
      name: 'Dream Journal Analyzer',
      description:
          'An intelligent dream journal app that allows users to record, analyze, and gain insights from their dreams using NLP and pattern recognition.',
      shortDescription: 'Record and analyze dreams with AI-powered pattern recognition.',
      technologies: ['Flutter', 'Dart', 'Python', 'Firebase', 'ML Kit'],
      githubUrl: 'https://github.com/shivamkumar/dream-journal',
      imageUrl: 'https://via.placeholder.com/400x250/00D4FF/FFFFFF?text=Dream+Journal',
      category: 'Mobile App',
      isFeatured: true,
    ),
    ProjectModel(
      id: '3',
      name: 'Inventory Management System',
      description:
          'A comprehensive inventory management system for small businesses with product tracking, stock alerts, sales reporting, and real-time sync via Firebase.',
      shortDescription: 'Complete inventory tracking solution with real-time sync and analytics.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Firestore'],
      githubUrl: 'https://github.com/shivamkumar/inventory-management',
      imageUrl: 'https://via.placeholder.com/400x250/FF6584/FFFFFF?text=Inventory+System',
      category: 'Business',
      isFeatured: true,
    ),
    ProjectModel(
      id: '4',
      name: 'Music Player App',
      description:
          'A feature-rich music player with beautiful glassmorphism UI. Supports local music playback, playlists, equalizer settings, and lyrics display.',
      shortDescription: 'Beautiful music player with equalizer, playlists, and lyrics.',
      technologies: ['Flutter', 'Dart', 'just_audio', 'audio_service'],
      githubUrl: 'https://github.com/shivamkumar/music-player',
      imageUrl: 'https://via.placeholder.com/400x250/9D97FF/FFFFFF?text=Music+Player',
      category: 'Mobile App',
      isFeatured: false,
    ),
    ProjectModel(
      id: '5',
      name: 'Educational Notes App',
      description:
          'A student-focused notes app for organizing study materials with rich text editor, subject categorization, PDF export, and cloud sync.',
      shortDescription: 'Smart notes app for students with rich text editing and PDF export.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Hive', 'PDF'],
      githubUrl: 'https://github.com/shivamkumar/edu-notes',
      imageUrl: 'https://via.placeholder.com/400x250/10B981/FFFFFF?text=Edu+Notes',
      category: 'Education',
      isFeatured: false,
    ),
    ProjectModel(
      id: '6',
      name: 'Snack Ordering Website',
      description:
          'A responsive web application for ordering snacks online. Features product browsing, cart management, order tracking, and secure payment integration.',
      shortDescription: 'Responsive food ordering platform with cart and order tracking.',
      technologies: ['Flutter Web', 'Dart', 'Firebase', 'REST API'],
      githubUrl: 'https://github.com/shivamkumar/snack-ordering',
      liveDemoUrl: 'https://snack-ordering-demo.web.app',
      imageUrl: 'https://via.placeholder.com/400x250/F59E0B/FFFFFF?text=Snack+Ordering',
      category: 'Web App',
      isFeatured: true,
    ),
    ProjectModel(
      id: '7',
      name: 'Future Project',
      description:
          'Currently working on an exciting new project! Stay tuned for updates. This will be a cutting-edge application leveraging the latest Flutter features.',
      shortDescription: 'Exciting new project coming soon — stay tuned!',
      technologies: ['Flutter', 'Dart', 'Firebase'],
      githubUrl: 'https://github.com/shivamkumar',
      imageUrl: 'https://via.placeholder.com/400x250/3D35CC/FFFFFF?text=Coming+Soon',
      category: 'Coming Soon',
      isFeatured: false,
    ),
  ];

  Future<void> _onLoadProjects(
      LoadProjects event, Emitter<ProjectsState> emit) async {
    emit(const ProjectsLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    emit(ProjectsLoaded(
      projects: _allProjects,
      filteredProjects: _allProjects,
      activeFilter: 'All',
    ));
  }

  void _onFilterProjects(
      FilterProjects event, Emitter<ProjectsState> emit) {
    if (state is ProjectsLoaded) {
      final loaded = state as ProjectsLoaded;
      final filtered = event.category == 'All'
          ? _allProjects
          : _allProjects
              .where((p) => p.category == event.category)
              .toList();
      emit(ProjectsLoaded(
        projects: loaded.projects,
        filteredProjects: filtered,
        activeFilter: event.category,
      ));
    }
  }

  Future<void> _onOpenGithub(
      OpenGithub event, Emitter<ProjectsState> emit) async {
    await UrlLauncherUtils.openUrl(event.url);
  }

  Future<void> _onOpenLiveDemo(
      OpenLiveDemo event, Emitter<ProjectsState> emit) async {
    await UrlLauncherUtils.openUrl(event.url);
  }
}
