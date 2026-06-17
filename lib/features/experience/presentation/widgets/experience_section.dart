import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../../data/models/experience_model.dart';
import '../bloc/experience_bloc.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (context, state) {
        if (state is ExperienceInitial) {
          context.read<ExperienceBloc>().add(const LoadExperienceData());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, ExperienceState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Experience',
            subtitle: 'WORK HISTORY',
          ),
          const SizedBox(height: 60),
          if (state is ExperienceLoaded)
            _buildTimeline(context, state.experiences)
          else if (state is ExperienceLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildTimeline(
      BuildContext context, List<ExperienceModel> experiences) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final exp = experiences[index];
        final isFirst = index == 0;
        final isLast = index == experiences.length - 1;

        return FadeInUp(
          delay: Duration(milliseconds: index * 200),
          child: TimelineTile(
            axis: TimelineAxis.vertical,
            alignment: TimelineAlign.manual,
            lineXY: 0.08,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 50,
              height: 50,
              indicator: _buildIndicator(context, exp),
            ),
            beforeLineStyle: LineStyle(
              color: exp.isCurrent
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.4),
              thickness: 2,
            ),
            afterLineStyle: LineStyle(
              color: exp.isCurrent
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.4),
              thickness: 2,
            ),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 32),
              child: _ExperienceCard(experience: exp),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildIndicator(BuildContext context, ExperienceModel exp) {
    return Container(
      decoration: BoxDecoration(
        gradient: exp.isCurrent
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: exp.isCurrent ? null : AppColors.primary.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: exp.isCurrent
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Center(
        child: Icon(
          Icons.work_outline,
          size: 20,
          color: exp.isCurrent ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceModel experience;

  const _ExperienceCard({required this.experience});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isExpanded = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(_isHovered ? 4.0 : 0.0, 0.0, 0),
        child: GlassCard(
          borderColor: widget.experience.isCurrent
              ? AppColors.primary.withOpacity(0.4)
              : null,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.experience.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                            if (widget.experience.isCurrent)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: AppColors.primaryGradient),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Current',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.experience.company,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _buildBadge(
                      Icons.calendar_today_outlined,
                      widget.experience.duration),
                  _buildBadge(
                      Icons.business_center_outlined,
                      widget.experience.type),
                ],
              ),
              const SizedBox(height: 16),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Column(
                  children: widget.experience.responsibilities
                      .take(2)
                      .map((r) => _buildResponsibility(context, r))
                      .toList(),
                ),
                secondChild: Column(
                  children: widget.experience.responsibilities
                      .map((r) => _buildResponsibility(context, r))
                      .toList(),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              if (widget.experience.responsibilities.length > 2)
                GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Text(
                          _isExpanded ? 'Show less' : 'Show more',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.experience.skills
                    .map((s) => _buildSkillChip(context, s))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsibility(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Text(
        skill,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.accent,
        ),
      ),
    );
  }
}
