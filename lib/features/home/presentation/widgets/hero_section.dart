import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../core/widgets/animated_button.dart';
import '../../../../core/widgets/gradient_text.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;
  final VoidCallback onResumeTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onResumeTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  final List<String> _roles = [
    'Flutter Developer',
    'Mobile App Developer',
    'Software Developer',
    'Dart Enthusiast',
  ];
  int _roleIndex = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _roleIndex = (_roleIndex + 1) % _roles.length);
          _controller.reset();
          _controller.forward();
        }
      });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? AppColors.heroGradientDark
              : AppColors.heroGradientLight,
        ),
      ),
      child: Stack(
        children: [
          // Background decorations
          Positioned(
            top: -100,
            right: -100,
            child: _buildGlowCircle(300, AppColors.primary.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: _buildGlowCircle(250, AppColors.secondary.withOpacity(0.1)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            right: MediaQuery.of(context).size.width * 0.15,
            child: _buildGlowCircle(150, AppColors.accent.withOpacity(0.08)),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.horizontalPadding(context),
              vertical: 80,
            ),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isTablet),
          ),
          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeInUp(
              delay: const Duration(milliseconds: 1200),
              child: Center(child: _buildScrollIndicator(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextContent(context)),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildAvatarSection(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        _buildAvatarSection(context),
        const SizedBox(height: 40),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInLeft(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for work',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          child: Text(
            "Hello, I'm",
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w400,
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 8),
        FadeInLeft(
          delay: const Duration(milliseconds: 300),
          child: GradientText(
            AppConstants.name,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 38 : 56,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1.1,
            ),
            colors: AppColors.primaryGradient,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 12),
        FadeInLeft(
          delay: const Duration(milliseconds: 400),
          child: _buildAnimatedRole(context, isMobile),
        ),
        const SizedBox(height: 20),
        FadeInLeft(
          delay: const Duration(milliseconds: 500),
          child: Text(
            'Passionate about building beautiful, high-performance\nmobile & web applications with Flutter & Dart.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              height: 1.7,
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment:
                isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              AnimatedGradientButton(
                text: 'Download Resume',
                icon: Icons.download_rounded,
                onPressed: widget.onResumeTap,
              ),
              AnimatedGradientButton(
                text: 'Contact Me',
                icon: Icons.email_outlined,
                onPressed: widget.onContactTap,
                isOutlined: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          delay: const Duration(milliseconds: 700),
          child: _buildSocialLinks(context, isMobile),
        ),
      ],
    );
  }

  Widget _buildAnimatedRole(BuildContext context, bool isMobile) {
    return SizedBox(
      height: 40,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Row(
          key: ValueKey(_roleIndex),
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 28,
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
            Flexible(
              child: Text(
                _roles[_roleIndex],
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final size = isMobile ? 200.0 : 320.0;

    return FadeInRight(
      delay: const Duration(milliseconds: 400),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: size + 40,
              height: size + 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Rotating border
            Container(
              width: size + 20,
              height: size + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                    AppColors.accent,
                    AppColors.primary,
                  ],
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .rotate(duration: const Duration(seconds: 8)),
            // Avatar
            Container(
              width: size + 10,
              height: size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipOval(
                child: _buildAvatarContent(size),
              ),
            ),
            // Floating tech badges
            if (!isMobile) ...[
              _buildFloatingBadge(
                  'Flutter', AppColors.flutterColor,
                  Offset(-(size / 2 + 10), -size / 6)),
              _buildFloatingBadge(
                  'Dart', AppColors.dartColor,
                  Offset(size / 2 + 10, -size / 6)),
              _buildFloatingBadge(
                  'Firebase', AppColors.firebaseColor,
                  Offset(-(size / 2 - 20), size / 3)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarContent(double size) {
    return Image.asset(
      AppConstants.profileImage,
      fit: BoxFit.cover,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              'SK',
              style: GoogleFonts.poppins(
                fontSize: size * 0.3,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingBadge(String label, Color color, Offset offset) {
    return Transform.translate(
      offset: offset,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
            begin: 0,
            end: -8,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut);
  }

  Widget _buildSocialLinks(BuildContext context, bool isMobile) {
    final socials = [
      (FontAwesomeIcons.github, AppConstants.githubUrl, 'GitHub'),
      (FontAwesomeIcons.linkedin, AppConstants.linkedinUrl, 'LinkedIn'),
      (Icons.email_outlined, 'mailto:${AppConstants.email}', 'Email'),
    ];

    return Wrap(
      spacing: 12,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: socials.map((s) {
        return _SocialButton(
          icon: s.$1,
          url: s.$2,
          tooltip: s.$3,
        );
      }).toList(),
    );
  }

  Widget _buildScrollIndicator(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          'Scroll Down',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 28,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Container(
              width: 5,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(3),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .moveY(
                    begin: -6,
                    end: 6,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut),
          ),
        ),
      ],
    );
  }

  Widget _buildGlowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final dynamic icon;
  final String url;
  final String tooltip;

  const _SocialButton({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => UrlLauncherUtils.openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: widget.icon is FaIconData
                  ? FaIcon(
                      widget.icon as FaIconData,
                      size: 16,
                      color: _isHovered ? Colors.white : AppColors.primary,
                    )
                  : Icon(
                      widget.icon as IconData,
                      size: 18,
                      color: _isHovered ? Colors.white : AppColors.primary,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
