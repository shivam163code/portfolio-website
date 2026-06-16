import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../bloc/skills_bloc.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillsBloc, SkillsState>(
      builder: (context, state) {
        if (state is SkillsInitial) {
          context.read<SkillsBloc>().add(const LoadSkills());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, SkillsState state) {
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
            title: 'My Skills',
            subtitle: 'EXPERTISE',
          ),
          const SizedBox(height: 60),
          if (state is SkillsLoading)
            const Center(child: CircularProgressIndicator())
          else if (state is SkillsLoaded)
            _buildSkillsGrid(context, state.categories)
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, List<SkillCategory> categories) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final crossAxisCount = isMobile ? 1 : (ResponsiveUtils.isTablet(context) ? 2 : 3);

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isMobile ? 1.3 : 1.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _SkillCategoryCard(category: categories[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;

  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;
  bool _isVisible = false;

  Color _hexToColor(String hex) {
    return Color(
        int.parse(hex.replaceAll('#', ''), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final color = _hexToColor(widget.category.color);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: VisibilityDetectorWrapper(
        onVisible: () => setState(() => _isVisible = true),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -6.0 : 0.0, 0),
          child: GlassCard(
            padding: const EdgeInsets.all(24),
            borderColor: _isHovered ? color.withOpacity(0.4) : null,
            backgroundColor: isDark
                ? Colors.white.withOpacity(_isHovered ? 0.08 : 0.04)
                : Colors.white.withOpacity(_isHovered ? 0.9 : 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(widget.category.icon),
                        color: color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.category.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.category.skills.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final skill = widget.category.skills[index];
                      return _buildSkillBar(
                          context, skill, color, _isVisible);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillBar(
      BuildContext context, SkillItem skill, Color color, bool animate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              '${skill.percentage}%',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearPercentIndicator(
          percent: animate ? skill.percentage / 100 : 0,
          lineHeight: 6,
          backgroundColor: color.withOpacity(0.15),
          progressColor: color,
          barRadius: const Radius.circular(3),
          padding: EdgeInsets.zero,
          animateFromLastPercent: true,
          animation: true,
          animationDuration: 800,
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String icon) {
    switch (icon) {
      case 'flutter':
        return Icons.flutter_dash;
      case 'code':
        return Icons.code;
      case 'web':
        return Icons.web;
      case 'database':
        return Icons.storage;
      case 'tools':
        return Icons.build_outlined;
      default:
        return Icons.star;
    }
  }
}

// Simple visibility detector wrapper
class VisibilityDetectorWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onVisible;

  const VisibilityDetectorWrapper({
    super.key,
    required this.child,
    required this.onVisible,
  });

  @override
  State<VisibilityDetectorWrapper> createState() =>
      _VisibilityDetectorWrapperState();
}

class _VisibilityDetectorWrapperState
    extends State<VisibilityDetectorWrapper> {
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && !_triggered) {
        _triggered = true;
        widget.onVisible();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
