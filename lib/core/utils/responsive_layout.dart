import 'package:flutter/material.dart';
import '../constants/app_breakpoints.dart';

/// Helper widget to render different layouts based on screen width
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppBreakpoints.compact;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.compact && width < AppBreakpoints.medium;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppBreakpoints.medium;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= AppBreakpoints.medium && desktop != null) {
      return desktop!;
    } else if (width >= AppBreakpoints.compact && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}
