import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double horizontalPadding(BuildContext context) {
    final w = screenWidth(context);
    if (w >= 1400) return w * 0.12;
    if (w >= 1200) return w * 0.08;
    if (w >= 768) return 48;
    return 24;
  }

  static double sectionVerticalPadding(BuildContext context) {
    return isMobile(context) ? 60 : 100;
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) return desktop;
      if (constraints.maxWidth >= 768) return tablet ?? desktop;
      return mobile;
    });
  }
}
