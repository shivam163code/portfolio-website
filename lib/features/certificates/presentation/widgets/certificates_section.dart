import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../../data/models/certificate_model.dart';
import '../bloc/certificate_bloc.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CertificateBloc, CertificateState>(
      builder: (context, state) {
        if (state is CertificateInitial) {
          context.read<CertificateBloc>().add(const LoadCertificates());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, CertificateState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Certificates',
            subtitle: 'ACHIEVEMENTS',
          ),
          const SizedBox(height: 60),
          if (state is CertificateLoaded)
            _buildCertificatesGrid(context, state.certificates)
          else if (state is CertificateLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildCertificatesGrid(
      BuildContext context, List<CertificateModel> certificates) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isMobile ? 1.5 : 1.1,
        ),
        itemCount: certificates.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _CertificateCard(certificate: certificates[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CertificateCard extends StatefulWidget {
  final CertificateModel certificate;

  const _CertificateCard({required this.certificate});

  @override
  State<_CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<_CertificateCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -8.0 : 0.0, 0),
        child: GlassCard(
          padding: EdgeInsets.zero,
          borderColor: _isHovered ? AppColors.primary.withOpacity(0.4) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Certificate image/preview
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.secondary.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: Image.network(
                        widget.certificate.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildCertPlaceholder(),
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return _buildCertPlaceholder();
                        },
                      ),
                    ),
                    // Overlay
                    if (_isHovered)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.8),
                                AppColors.secondary.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Center(
                            child: TextButton.icon(
                              onPressed: () {
                                if (widget.certificate.certificateUrl != null) {
                                  context.read<CertificateBloc>().add(
                                      OpenCertificate(
                                          widget.certificate.certificateUrl!));
                                }
                              },
                              icon: const Icon(Icons.visibility_outlined,
                                  color: Colors.white),
                              label: Text(
                                'View Certificate',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.certificate.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.business_outlined,
                                size: 12, color: AppColors.primary),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.certificate.organization,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 12,
                              color: Theme.of(context).colorScheme.onSurface),
                          const SizedBox(width: 6),
                          Text(
                            widget.certificate.issueDate,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionBtn(
                              context,
                              Icons.visibility_outlined,
                              'View',
                              () {
                                if (widget.certificate.certificateUrl != null) {
                                  context.read<CertificateBloc>().add(
                                      OpenCertificate(
                                          widget.certificate.certificateUrl!));
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildActionBtn(
                              context,
                              Icons.download_outlined,
                              'Download',
                              () {
                                if (widget.certificate.certificateUrl != null) {
                                  context.read<CertificateBloc>().add(
                                      OpenCertificate(
                                          widget.certificate.certificateUrl!));
                                }
                              },
                              isPrimary: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.secondary.withOpacity(0.15),
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.workspace_premium_outlined,
            size: 48, color: AppColors.primary),
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, IconData icon, String label,
      VoidCallback onTap,
      {bool isPrimary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : null,
          color: isPrimary ? null : AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPrimary
                ? Colors.transparent
                : AppColors.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 14,
                color: isPrimary ? Colors.white : AppColors.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
