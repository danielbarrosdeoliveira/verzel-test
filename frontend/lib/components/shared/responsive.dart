import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget extraSmallScreen;
  final Widget smallScreen;
  final Widget mediumScreen;
  final Widget largeScreen;
  final Widget extraLargeScreen;

  const ResponsiveWidget({
    Key? key,
    required this.extraSmallScreen,
    required this.smallScreen,
    required this.mediumScreen,
    required this.largeScreen,
    required this.extraLargeScreen,
  }) : super(key: key);

  static bool isExtraSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 400;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 400 &&
        MediaQuery.of(context).size.width < 720;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 720 &&
        MediaQuery.of(context).size.width < 960;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 960 &&
        MediaQuery.of(context).size.width < 1280;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1280;
  }

  @override
  Widget build(BuildContext context) {
    if (isExtraLargeScreen(context)) {
      return extraLargeScreen;
    } else if (isLargeScreen(context)) {
      return largeScreen;
    } else if (isMediumScreen(context)) {
      return mediumScreen;
    } else if (isSmallScreen(context)) {
      return smallScreen;
    } else {
      return extraSmallScreen;
    }
  }
}
