import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart' show secondaryTextColor, surfaceColor, tagWarningColor;

class CircleCheckRadio extends StatelessWidget {
  final String label;          // 文本
  final bool isSelected;       // 是否选中
  final VoidCallback onTap;    // 点击回调

  const CircleCheckRadio({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.85,
            child: Checkbox(
              value: isSelected,
              // splashRadius: 0.0,
              onChanged: (value) => onTap(),
              shape: CircleBorder(),
              side: BorderSide(
                color: isSelected
                    ? tagWarningColor
                    : secondaryTextColor,
                width: 2,
              ),
              activeColor: tagWarningColor,
              checkColor: surfaceColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}