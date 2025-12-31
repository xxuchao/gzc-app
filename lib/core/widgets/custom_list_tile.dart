import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart' show diverColor;
import 'package:gzc_app/core/theme/spacing.dart';

class CustomListTile extends StatelessWidget {
  final String title;                    // 左侧标题（必填）
  final Widget? leadingIcon;             // 左侧图标（可选）
  final Widget? trailing;                // 右侧自定义 widget（完全由用户控制）
  final bool showTrailingArrow;          // 是否显示右侧箭头（独立于 trailing）
  final VoidCallback? onTap;             // 点击回调
  final bool showBottomBorder;           // 是否显示底部边框
  final double? horizontalPadding;       // 水平内边距
  final double? verticalPadding;         // 垂直内边距

  const CustomListTile({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailing,
    this.showTrailingArrow = false,
    this.onTap,
    this.showBottomBorder = false,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    // 独立的箭头（仅当 showTrailingArrow 为 true 时创建）
    Widget? arrowWidget;
    if (showTrailingArrow) {
      arrowWidget = Icon(
        Icons.chevron_right,
        size: Spacing.iconMd,
        color: Theme.of(context).disabledColor,
      );
    }

    Widget content = Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? Spacing.pageHorizontal,
        vertical: verticalPadding ?? Spacing.cardGap,
      ),

      decoration: BoxDecoration(
        border: showBottomBorder
          ? Border(
              bottom: BorderSide(
                color: diverColor,
                width: 0.5,
              ),
            )
          : null,
      ),
      child: Row(
        children: [
          // 左侧图标
          if (leadingIcon != null) ...[
            Padding(
              padding: EdgeInsets.only(right: Spacing.xs),
              child: leadingIcon,
            ),
          ],
          // 标题（固定样式）
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 用户传入的 trailing（原样使用）
          if (trailing != null) ...[
            SizedBox(width: Spacing.xs),
            trailing!,
          ],
          // 独立箭头（即使有 trailing 也追加）
          if (arrowWidget != null) ...[
            SizedBox(width: Spacing.xs),
            arrowWidget,
          ],
        ],
      ),
    );

    // 仅在需要点击时包裹 InkWell，不加 Material
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}