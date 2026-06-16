import 'package:equatable/equatable.dart';

class CertificateModel extends Equatable {
  final String id;
  final String name;
  final String organization;
  final String issueDate;
  final String? expiryDate;
  final String? certificateUrl;
  final String imageUrl;
  final String credentialId;

  const CertificateModel({
    required this.id,
    required this.name,
    required this.organization,
    required this.issueDate,
    this.expiryDate,
    this.certificateUrl,
    required this.imageUrl,
    required this.credentialId,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      CertificateModel(
        id: json['id'] as String,
        name: json['name'] as String,
        organization: json['organization'] as String,
        issueDate: json['issueDate'] as String,
        expiryDate: json['expiryDate'] as String?,
        certificateUrl: json['certificateUrl'] as String?,
        imageUrl: json['imageUrl'] as String,
        credentialId: json['credentialId'] as String,
      );

  @override
  List<Object?> get props => [id, name, organization, issueDate];
}
