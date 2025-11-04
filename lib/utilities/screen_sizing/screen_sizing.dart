import 'package:flutter/material.dart';

class ScreenSizing {
  static const double tablet = 1200;

  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width < tablet;

  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= tablet;
}
