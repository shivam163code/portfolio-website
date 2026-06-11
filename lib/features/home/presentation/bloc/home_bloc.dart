import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<DownloadResume>(_onDownloadResume);
    on<OpenContact>(_onOpenContact);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(HomeLoaded(
      name: AppConstants.name,
      title: AppConstants.title,
      about: AppConstants.aboutText,
    ));
  }

  Future<void> _onDownloadResume(
      DownloadResume event, Emitter<HomeState> emit) async {
    await UrlLauncherUtils.openUrl(AppConstants.resumeUrl);
  }

  Future<void> _onOpenContact(
      OpenContact event, Emitter<HomeState> emit) async {
    await UrlLauncherUtils.openEmail(AppConstants.email,
        subject: 'Hello Shivam');
  }
}
