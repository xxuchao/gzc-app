import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool material;
  final bool radius;
  final Color? color;
  const CustomCard({super.key, required this.child, this.padding, this.material = false, this.radius = true, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: Spacing.cardGap),
      padding: padding ?? EdgeInsets.all(Spacing.pageHorizontal),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: radius == true ? BorderRadius.circular(Spacing.radiusMd) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: Spacing.radiusMd,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: material ? Material(color: Colors.transparent, child: child,) : child,
    );
  }
}