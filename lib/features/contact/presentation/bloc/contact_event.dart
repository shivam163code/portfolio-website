part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  List<Object?> get props => [];
}

class SendMessage extends ContactEvent {
  final String name;
  final String email;
  final String subject;
  final String message;
  const SendMessage({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });
  @override
  List<Object?> get props => [name, email, subject, message];
}

class OpenLinkedIn extends ContactEvent {
  const OpenLinkedIn();
}

class OpenGithubContact extends ContactEvent {
  const OpenGithubContact();
}

class OpenEmailContact extends ContactEvent {
  const OpenEmailContact();
}

class ResetContact extends ContactEvent {
  const ResetContact();
}
