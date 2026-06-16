import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../../data/models/education_model.dart';
import '../bloc/education_bloc.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationBloc, EducationState>(
      builder: (context, state) {
        if (state is EducationInitial) {
          context.read<EducationBloc>().add(const LoadEducationData());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, EducationState state) {
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
            title: 'Education',
            subtitle: 'MY JOURNEY',
          ),
          const SizedBox(height: 60),
          if (state is EducationLoaded)
            _buildTimeline(context, state.educations)
          else if (state is EducationLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildTimeline(
      BuildContext context, List<EducationModel> educations) {
    return Column(
      children: List.generate(educations.length, (index) {
        final edu = educations[index];
        final isFirst = index == 0;
        final isLast = index == educations.length - 1;

        return FadeInUp(
          delay: Duration(milliseconds: index * 200),
          child: TimelineTile(
            axis: TimelineAxis.vertical,
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 50,
              height: 50,
              indicator: _buildIndicator(context, edu),
            ),
            beforeLineStyle: const LineStyle(
              color: AppColors.primary,
              thickness: 2,
            ),
            afterLineStyle: const LineStyle(
              color: AppColors.primary,
              thickness: 2,
            ),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 32),
              child: _EducationCard(education: edu),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildIndicator(BuildContext context, EducationModel edu) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _getLevelShorthand(edu.level),
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _getLevelShorthand(String level) {
    switch (level) {
      case 'btech':
        return 'B.T';
      case '12th':
        return '12';
      case '10th':
        return '10';
      default:
        return level;
    }
  }
}

class _EducationCard extends StatefulWidget {
  final EducationModel education;

  const _EducationCard({required this.education});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.education.level == 'btech';
    final isMobile = ResponsiveUtils.isMobile(context);

    final titleWidget = Text(
      _getLevelTitle(widget.education.level),
      style: GoogleFonts.poppins(
        fontSize: isMobile ? 16 : 18,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );

    final currentBadge = isCurrent
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Current',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        : const SizedBox.shrink();

    final yearBadge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        widget.education.year,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(_isHovered ? 4.0 : 0.0, 0.0, 0),
        child: GlassCard(
          borderColor:
              isCurrent ? AppColors.primary.withOpacity(0.4) : null,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile) ...[
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    titleWidget,
                    if (isCurrent) currentBadge,
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.education.instituteName,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                yearBadge,
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: titleWidget),
                              if (isCurrent) ...[
                                const SizedBox(width: 10),
                                currentBadge,
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.education.instituteName,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    yearBadge,
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.account_balance_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface),
                  const SizedBox(width: 6),
                  Text(
                    widget.education.board,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.education.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.6,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              // Stats row
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  if (widget.education.percentage != null)
                    _buildStat(context, 'Score',
                        widget.education.percentage!, Icons.star_outline),
                  if (widget.education.cgpa != null)
                    _buildStat(context, 'CGPA', widget.education.cgpa!,
                        Icons.school_outlined),
                  if (widget.education.currentSemester != null)
                    _buildStat(
                        context,
                        'Semester',
                        widget.education.currentSemester!,
                        Icons.book_outlined),
                  if (widget.education.currentYear != null)
                    _buildStat(
                        context,
                        'Year',
                        widget.education.currentYear!,
                        Icons.calendar_today_outlined),
                ],
              ),
              if (widget.education.marksheetUrl != null) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => context
                          .read<EducationBloc>()
                          .add(ViewMarksheet(
                              widget.education.marksheetUrl!)),
                      icon: const Icon(Icons.visibility_outlined, size: 16),
                      label: const Text('View Marksheet'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        textStyle: GoogleFonts.inter(fontSize: 13),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context
                          .read<EducationBloc>()
                          .add(ViewMarksheet(
                              widget.education.marksheetUrl!)),
                      icon: const Icon(Icons.download_outlined, size: 16),
                      label: const Text('Download'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        textStyle: GoogleFonts.inter(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(
      BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getLevelTitle(String level) {
    switch (level) {
      case 'btech':
        return 'B.Tech – Computer Science Engineering';
      case '12th':
        return 'Class XII – Senior Secondary';
      case '10th':
        return 'Class X – Secondary';
      default:
        return level;
    }
  }
}
