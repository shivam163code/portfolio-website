import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(const ContactInitial()) {
    on<SendMessage>(_onSendMessage);
    on<OpenLinkedIn>(_onOpenLinkedIn);
    on<OpenGithubContact>(_onOpenGithub);
    on<OpenEmailContact>(_onOpenEmail);
    on<ResetContact>(_onReset);
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ContactState> emit) async {
    emit(const ContactLoading());
    await Future.delayed(const Duration(seconds: 1));
    // Simulate sending via email
    await UrlLauncherUtils.openEmail(
      AppConstants.email,
      subject: event.subject,
      body: 'Name: ${event.name}\nEmail: ${event.email}\n\n${event.message}',
    );
    emit(const ContactSuccess(
        'Message sent successfully! I will get back to you soon.'));
  }

  Future<void> _onOpenLinkedIn(
      OpenLinkedIn event, Emitter<ContactState> emit) async {
    await UrlLauncherUtils.openUrl(AppConstants.linkedinUrl);
  }

  Future<void> _onOpenGithub(
      OpenGithubContact event, Emitter<ContactState> emit) async {
    await UrlLauncherUtils.openUrl(AppConstants.githubUrl);
  }

  Future<void> _onOpenEmail(
      OpenEmailContact event, Emitter<ContactState> emit) async {
    await UrlLauncherUtils.openEmail(AppConstants.email);
  }

  void _onReset(ResetContact event, Emitter<ContactState> emit) {
    emit(const ContactInitial());
  }
}
