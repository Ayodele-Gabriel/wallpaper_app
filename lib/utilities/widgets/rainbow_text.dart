import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text.dart';
import '../screen_sizing/screen_sizing.dart';

class RainbowText extends StatelessWidget {
  const RainbowText(this.rainbowText, {super.key});

  final String rainbowText;
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ScreenSizing.isDesktop(context);
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [AppColors.rainbowTextColor1, AppColors.rainbowTextColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        rainbowText,
        style: AppText.rainbowText.copyWith(
          fontSize: isDesktop ? 60.0 : 28.0,
          fontFamily: 'ClashDisplay',
        ),
      ),
    );
  }
}
