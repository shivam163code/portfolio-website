part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {
  const ContactInitial();
}

class ContactLoading extends ContactState {
  const ContactLoading();
}

class ContactSuccess extends ContactState {
  final String message;
  const ContactSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ContactError extends ContactState {
  final String message;
  const ContactError(this.message);
  @override
  List<Object?> get props => [message];
}
