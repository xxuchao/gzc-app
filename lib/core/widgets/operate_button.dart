import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class OperateButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool showBorder;
  final BorderSide? borderSide;
  final VoidCallback onPressed;

  const OperateButton(
    this.text,
    this.onPressed,
    {
    super.key,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.width,
    this.height,
    this.showBorder = false,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? Spacing.radiusMd),
            side: showBorder ? borderSide ?? BorderSide(color: Colors.transparent) : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}