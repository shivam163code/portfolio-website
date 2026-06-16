part of 'certificate_bloc.dart';

abstract class CertificateEvent extends Equatable {
  const CertificateEvent();
  @override
  List<Object?> get props => [];
}

class LoadCertificates extends CertificateEvent {
  const LoadCertificates();
}

class OpenCertificate extends CertificateEvent {
  final String url;
  const OpenCertificate(this.url);
  @override
  List<Object?> get props => [url];
}
