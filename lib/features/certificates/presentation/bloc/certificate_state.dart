part of 'certificate_bloc.dart';

abstract class CertificateState extends Equatable {
  const CertificateState();
  @override
  List<Object?> get props => [];
}

class CertificateInitial extends CertificateState {
  const CertificateInitial();
}

class CertificateLoading extends CertificateState {
  const CertificateLoading();
}

class CertificateLoaded extends CertificateState {
  final List<CertificateModel> certificates;
  const CertificateLoaded(this.certificates);
  @override
  List<Object?> get props => [certificates];
}

class CertificateError extends CertificateState {
  final String message;
  const CertificateError(this.message);
  @override
  List<Object?> get props => [message];
}
