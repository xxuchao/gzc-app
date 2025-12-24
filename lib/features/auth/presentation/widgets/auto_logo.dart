import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:gzc_app/core/constants/app_images.dart" show AppImages;
import "package:gzc_app/core/theme/colors.dart" show surfaceColor;
import "package:gzc_app/core/theme/spacing.dart" show Spacing;

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 90.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Spacing.radiusXXL)
      ),
      child: Center(
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: Spacing.lg, bottom: Spacing.xxl),
      child: Text(
        "云尚存",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: surfaceColor, fontWeight: FontWeight.w700),
      ),
    );
  }
}