import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, this.width, required this.color, this.borderColor, required this.child});

  final void Function()? onPressed;
  final double? width;
  final Color color;
  final Color? borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 218.0,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(child: child),
      ),
    );
  }
}