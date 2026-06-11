import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/certificate_model.dart';
import '../../../../core/utils/url_launcher_utils.dart';

part 'certificate_event.dart';
part 'certificate_state.dart';

class CertificateBloc extends Bloc<CertificateEvent, CertificateState> {
  CertificateBloc() : super(const CertificateInitial()) {
    on<LoadCertificates>(_onLoadCertificates);
    on<OpenCertificate>(_onOpenCertificate);
  }

  final List<CertificateModel> _certificates = const [
    CertificateModel(
      id: '1',
      name: 'Flutter & Dart - The Complete Guide',
      organization: 'Udemy',
      issueDate: 'January 2024',
      certificateUrl: 'https://udemy.com/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/6C63FF/FFFFFF?text=Flutter+Certificate',
      credentialId: 'UC-flutter-dart-2024',
    ),
    CertificateModel(
      id: '2',
      name: 'Firebase for Flutter',
      organization: 'Google Developers',
      issueDate: 'March 2024',
      certificateUrl: 'https://developers.google.com/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/FFCA28/000000?text=Firebase+Certificate',
      credentialId: 'GD-firebase-flutter-2024',
    ),
    CertificateModel(
      id: '3',
      name: 'Python Programming Masterclass',
      organization: 'Coursera',
      issueDate: 'June 2023',
      certificateUrl: 'https://coursera.org/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/3572A5/FFFFFF?text=Python+Certificate',
      credentialId: 'COURSERA-PY-2023',
    ),
    CertificateModel(
      id: '4',
      name: 'Git & GitHub Complete Course',
      organization: 'LinkedIn Learning',
      issueDate: 'August 2023',
      certificateUrl: 'https://linkedin.com/learning/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/F05032/FFFFFF?text=Git+Certificate',
      credentialId: 'LI-GIT-2023',
    ),
    CertificateModel(
      id: '5',
      name: 'Java Programming Fundamentals',
      organization: 'NPTEL',
      issueDate: 'October 2023',
      certificateUrl: 'https://nptel.ac.in/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/B07219/FFFFFF?text=Java+Certificate',
      credentialId: 'NPTEL-JAVA-2023',
    ),
    CertificateModel(
      id: '6',
      name: 'REST API Development',
      organization: 'Postman',
      issueDate: 'December 2023',
      certificateUrl: 'https://badgr.com/certificate/sample',
      imageUrl: 'https://via.placeholder.com/400x280/FF6C37/FFFFFF?text=API+Certificate',
      credentialId: 'POSTMAN-API-2023',
    ),
  ];

  Future<void> _onLoadCertificates(
      LoadCertificates event, Emitter<CertificateState> emit) async {
    emit(const CertificateLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(CertificateLoaded(_certificates));
  }

  Future<void> _onOpenCertificate(
      OpenCertificate event, Emitter<CertificateState> emit) async {
    await UrlLauncherUtils.openUrl(event.url);
  }
}
