part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class DownloadResume extends HomeEvent {
  const DownloadResume();
}

class OpenContact extends HomeEvent {
  const OpenContact();
}

class ScrollToSection extends HomeEvent {
  final String sectionKey;
  const ScrollToSection(this.sectionKey);
  @override
  List<Object?> get props => [sectionKey];
}
