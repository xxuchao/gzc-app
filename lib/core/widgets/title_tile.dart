import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class TitleTile extends StatelessWidget {
  final String title;
  final Widget? sub;
  const TitleTile({super.key, this.title = "Title", this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: Spacing.xs,
          height: Theme.of(context).textTheme.bodyLarge?.fontSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary
          ),
        ),
        SizedBox(width: Spacing.xs,),
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),)
      ],),
      if (sub != null) sub!
    ],);
  }
}