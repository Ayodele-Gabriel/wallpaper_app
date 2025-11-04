import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppText {
  static const TextStyle appName = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400);

  static const TextStyle rainbowText = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.baseWhite,
  );

  static const TextStyle bigText = TextStyle(
    fontSize: 48.0,
    fontFamily: 'ClashDisplay',
  );

  static const TextStyle cardText1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
    color: AppColors.baseWhite,
  );

  static const TextStyle cardText2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0);

  static const TextStyle cardText3 = TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0);
}
