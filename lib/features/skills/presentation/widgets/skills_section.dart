import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
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
            isMobile || isTablet
                ? Column(
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/lottie/development.json',
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _SkillsSlider(categories: state.categories),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _SkillsSlider(categories: state.categories),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Lottie.asset(
                            'assets/lottie/development.json',
                            height: 320,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

}

class _SkillsSlider extends StatefulWidget {
  final List<SkillCategory> categories;

  const _SkillsSlider({required this.categories});

  @override
  State<_SkillsSlider> createState() => _SkillsSliderState();
}

class _SkillsSliderState extends State<_SkillsSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  bool _isHovered = false;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_isHovered && mounted && _totalPages > 1) {
        final nextPage = (_currentPage + 1) % _totalPages;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final int itemsPerPage = isMobile ? 1 : 2;

    final List<List<SkillCategory>> pages = [];
    for (var i = 0; i < widget.categories.length; i += itemsPerPage) {
      final end = (i + itemsPerPage < widget.categories.length)
          ? i + itemsPerPage
          : widget.categories.length;
      pages.add(widget.categories.sublist(i, end));
    }

    _totalPages = pages.length;
    if (_currentPage >= _totalPages) {
      _currentPage = _totalPages - 1;
    }
    if (_currentPage < 0) {
      _currentPage = 0;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          SizedBox(
            height: isMobile ? 350 : 400,
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, pageIndex) {
                final pageItems = pages[pageIndex];
                if (isMobile) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _SkillCategoryCard(category: pageItems[0]),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _SkillCategoryCard(category: pageItems[0]),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: pageItems.length > 1
                              ? _SkillCategoryCard(category: pageItems[1])
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pages.length, (index) {
              final isActive = _currentPage == index;
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isActive ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: isActive
                        ? const LinearGradient(colors: AppColors.primaryGradient)
                        : null,
                    color: isActive
                        ? null
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
              );
            }),
          ),
        ],
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
            borderColor: _isHovered ? color.withOpacity(0.4) : null,
            backgroundColor: isDark
                ? Colors.white.withOpacity(_isHovered ? 0.08 : 0.04)
                : Colors.white.withOpacity(_isHovered ? 0.9 : 0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                ...widget.category.skills.map((skill) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildSkillBar(context, skill, color, _isVisible),
                  );
                }).toList(),
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
