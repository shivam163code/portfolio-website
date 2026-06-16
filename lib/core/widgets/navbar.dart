import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../theme/theme_cubit.dart';
import '../utils/responsive_utils.dart';
import 'animated_button.dart';

class PortfolioNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final String activeSection;

  const PortfolioNavbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeSection,
  });

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar>
    with SingleTickerProviderStateMixin {
  bool _isScrolled = false;
  bool _isMobileMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    );
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(String section) {
    final key = widget.sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
    if (_isMobileMenuOpen) {
      setState(() => _isMobileMenuOpen = false);
      _menuController.reverse();
    }
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtils.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _isScrolled
            ? (isDark
                ? AppColors.darkSurface.withOpacity(0.95)
                : AppColors.lightSurface.withOpacity(0.95))
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
        border: _isScrolled
            ? Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: _isScrolled
              ? const ColorFilter.mode(Colors.transparent, BlendMode.color)
              : const ColorFilter.mode(Colors.transparent, BlendMode.color),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context),
              vertical: 16,
            ),
            child: isMobile
                ? _buildMobileNav(context, isDark)
                : _buildDesktopNav(context, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context, bool isDark) {
    return Row(
      children: [
        _buildLogo(context),
        const Spacer(),
        ...AppConstants.navItems.take(8).map(
              (item) => _NavItem(
                title: item,
                isActive: widget.activeSection == item.toLowerCase(),
                onTap: () => _scrollToSection(item.toLowerCase()),
              ),
            ),
        const SizedBox(width: 16),
        _buildThemeToggle(context, isDark),
        const SizedBox(width: 16),
        AnimatedGradientButton(
          text: 'Hire Me',
          onPressed: () => _scrollToSection('contact'),
          icon: Icons.email_outlined,
        ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            _buildLogo(context),
            const Spacer(),
            _buildThemeToggle(context, isDark),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);
                if (_isMobileMenuOpen) {
                  _menuController.forward();
                } else {
                  _menuController.reverse();
                }
              },
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _menuAnimation,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        SizeTransition(
          sizeFactor: _menuAnimation,
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Column(
              children: AppConstants.navItems.map(
                (item) => ListTile(
                  title: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontWeight: widget.activeSection == item.toLowerCase()
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: widget.activeSection == item.toLowerCase()
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  trailing: widget.activeSection == item.toLowerCase()
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null,
                  onTap: () => _scrollToSection(item.toLowerCase()),
                  dense: true,
                ),
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => _scrollToSection('home'),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.primaryGradient,
              ),
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
          const SizedBox(width: 10),
          Text(
            'Shivam Kumar',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => context.read<ThemeCubit>().toggleTheme(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: AppColors.primaryGradient),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: widget.isActive || _isHovered
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive || _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: AppColors.primaryGradient),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
