import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show surfaceColor, secondaryTextColor;
import 'package:gzc_app/core/theme/spacing.dart';

class BottomBox extends StatelessWidget {
  final Widget child;
  const BottomBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.verticalGapXS),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(color: secondaryTextColor, blurRadius: 2)
        ]
      ),
      child: child,
    );
  }
}