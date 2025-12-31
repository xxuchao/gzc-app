import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart' show tagWarningColor, secondaryTextColor, surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';

class VerificationBadge extends StatelessWidget {
  final bool isVerified;
  const VerificationBadge({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smx, vertical: Spacing.xs),
      decoration: BoxDecoration(
        color: isVerified ? tagWarningColor : secondaryTextColor,
        borderRadius: BorderRadius.circular(Spacing.radiusXXL),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.verified,
            color: surfaceColor,
            size: Spacing.iconSm,
          ),
          SizedBox(width: Spacing.xs),
          Text(
            isVerified ? '已实名认证' : '未实名认证',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: surfaceColor),
          ),
          if (!isVerified)
            Padding(
              padding: EdgeInsets.only(left: Spacing.xs),
              child: Icon(
                Icons.arrow_forward_ios,
                color: surfaceColor,
                size: Spacing.iconXXXS,
              ),
            ),
        ],
      ),
    );
  }
}