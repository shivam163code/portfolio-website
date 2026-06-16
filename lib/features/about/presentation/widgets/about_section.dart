import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../bloc/about_bloc.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        if (state is AboutInitial) {
          context.read<AboutBloc>().add(const LoadAboutData());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, AboutState state) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'About Me',
            subtitle: 'KNOW MORE',
          ),
          const SizedBox(height: 60),
          isMobile
              ? _buildMobileLayout(context, state)
              : _buildDesktopLayout(context, state),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AboutState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildInfoCard(context)),
        const SizedBox(width: 40),
        Expanded(flex: 7, child: _buildTextContent(context, state)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AboutState state) {
    return Column(
      children: [
        _buildInfoCard(context),
        const SizedBox(height: 32),
        _buildTextContent(context, state),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {

    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: [
          // Profile card
          GlassCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppConstants.profileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            'SK',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppConstants.name,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  AppConstants.shortTitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                ..._buildInfoItems(context),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Stats cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                    context, '7+', 'Projects\nCompleted', AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                    context, '4+', 'Years\nLearning', AppColors.secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoItems(BuildContext context) {
    final items = [
      (Icons.school_outlined, 'CGC Jhanjeri', 'College'),
      (Icons.book_outlined, 'B.Tech CSE', 'Degree'),
      (Icons.calendar_today_outlined, '4th Year, 7th Sem', 'Current Year'),
      (Icons.location_on_outlined, 'Chandigarh, India', 'Location'),
    ];

    return items.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.$1, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.$3,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    item.$2,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildStatCard(
      BuildContext context, String value, String label, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: [color, color.withOpacity(0.7)],
            ).createShader(bounds),
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, AboutState state) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who Am I?',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.aboutText,
            style: GoogleFonts.inter(
              fontSize: 15,
              height: 1.8,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 28),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryGradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Career Objective',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.careerObjective,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.7,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Technologies I Work With',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              'Flutter', 'Dart', 'Python', 'Java',
              'HTML', 'CSS', 'Firebase', 'MongoDB',
              'Git', 'GitHub', 'REST APIs',
            ].map((tech) => _buildTechChip(context, tech)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(BuildContext context, String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
      ),
      child: Text(
        tech,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
