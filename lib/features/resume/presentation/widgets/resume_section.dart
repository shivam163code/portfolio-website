import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/animated_button.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../bloc/resume_bloc.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumeBloc, ResumeState>(
      builder: (context, state) {
        if (state is ResumeInitial) {
          context.read<ResumeBloc>().add(const LoadResume());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, ResumeState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withOpacity(0.5)
            : AppColors.lightCard,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'My Resume',
            subtitle: 'DOWNLOAD CV',
          ),
          const SizedBox(height: 60),
          _buildResumeCard(context, state),
        ],
      ),
    );
  }

  Widget _buildResumeCard(BuildContext context, ResumeState state) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return FadeInUp(
      child: GlassCard(
        padding: const EdgeInsets.all(40),
        child: isMobile
            ? _buildMobileContent(context, state)
            : _buildDesktopContent(context, state),
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context, ResumeState state) {
    return Row(
      children: [
        Expanded(flex: 6, child: _buildResumeInfo(context)),
        const SizedBox(width: 40),
        Expanded(flex: 4, child: _buildResumePreview(context, state)),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context, ResumeState state) {
    return Column(
      children: [
        _buildResumePreview(context, state),
        const SizedBox(height: 32),
        _buildResumeInfo(context),
      ],
    );
  }

  Widget _buildResumeInfo(BuildContext context) {
    final highlights = [
      (Icons.flutter_dash, 'Flutter Development', 'Expert in building cross-platform apps'),
      (Icons.code, 'Clean Code', 'Writing maintainable, scalable code'),
      (Icons.architecture, 'Architecture', 'Clean Architecture & BLoC pattern'),
      (Icons.school_outlined, 'B.Tech CSE', 'Currently in 4th year at CGC Jhanjeri'),
      (Icons.work_outline, 'Projects', '7+ real-world projects completed'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to Contribute',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Download my resume to learn more about my skills, education, and projects.',
          style: GoogleFonts.inter(
            fontSize: 15,
            height: 1.7,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 28),
        ...highlights.map((h) => _buildHighlight(context, h.$1, h.$2, h.$3)),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            AnimatedGradientButton(
              text: 'Download Resume',
              icon: Icons.download_rounded,
              onPressed: () => context.read<ResumeBloc>().add(const DownloadResume()),
            ),
            AnimatedGradientButton(
              text: 'Open Resume',
              icon: Icons.open_in_new,
              onPressed: () => context.read<ResumeBloc>().add(const OpenResume()),
              isOutlined: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlight(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumePreview(BuildContext context, ResumeState state) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Mock resume lines
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMockResumeHeader(context),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                ...[0.9, 0.7, 0.8, 0.5, 0.75, 0.6, 0.85, 0.5]
                    .map((w) => _buildMockLine(context, w)),
              ],
            ),
          ),
          // Overlay button
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () => context
                  .read<ResumeBloc>()
                  .add(const OpenResume()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: AppColors.primaryGradient),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.zoom_in, size: 16, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'Preview Resume',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockResumeHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: AppColors.primaryGradient),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'SK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                Text(
                  'Flutter Developer',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMockLine(BuildContext context, double widthFactor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 8,
        width: double.infinity * widthFactor,
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
