import 'package:intl/intl.dart';

import 'package:flutter/widgets.dart';

import 'package:frontend/components/shared/responsive.dart';

final priceFormat = NumberFormat.currency(locale: 'pt_BR', name: '');

double getCardWidth(BuildContext context) {
  if (ResponsiveWidget.isExtraSmallScreen(context)) {
    return 100;
  } else if (ResponsiveWidget.isSmallScreen(context)) {
    return 140;
  } else if (ResponsiveWidget.isMediumScreen(context)) {
    return 140;
  } else if (ResponsiveWidget.isLargeScreen(context)) {
    return 160;
  } else {
    return 200;
  }
}

double getCardHeight(BuildContext context) {
  if (ResponsiveWidget.isExtraSmallScreen(context)) {
    return 80;
  } else if (ResponsiveWidget.isSmallScreen(context)) {
    return 120;
  } else if (ResponsiveWidget.isMediumScreen(context)) {
    return 120;
  } else if (ResponsiveWidget.isLargeScreen(context)) {
    return 100;
  } else {
    return 140;
  }
}

double getTitleFontSize(BuildContext context) {
  if (ResponsiveWidget.isExtraSmallScreen(context)) {
    return 14;
  } else if (ResponsiveWidget.isSmallScreen(context)) {
    return 14;
  } else if (ResponsiveWidget.isMediumScreen(context)) {
    return 18;
  } else if (ResponsiveWidget.isLargeScreen(context)) {
    return 18;
  } else {
    return 20;
  }
}

double getPriceFontSize(BuildContext context) {
  if (ResponsiveWidget.isExtraSmallScreen(context)) {
    return 18;
  } else if (ResponsiveWidget.isSmallScreen(context)) {
    return 20;
  } else if (ResponsiveWidget.isMediumScreen(context)) {
    return 26;
  } else if (ResponsiveWidget.isLargeScreen(context)) {
    return 26;
  } else {
    return 30;
  }
}

double getSpaceBetweenCards(BuildContext context) {
  if (ResponsiveWidget.isExtraSmallScreen(context)) {
    return 4;
  } else if (ResponsiveWidget.isSmallScreen(context)) {
    return 8;
  } else if (ResponsiveWidget.isMediumScreen(context)) {
    return 12;
  } else if (ResponsiveWidget.isLargeScreen(context)) {
    return 16;
  } else {
    return 16;
  }
}
