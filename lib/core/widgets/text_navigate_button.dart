// lib/core/widgets/text_navigate_button.dart
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

/// 文字跳转按钮：点击文字跳转到新页面
class TextNavigateButton extends StatelessWidget {
  /// 显示的文字内容
  final String text;

  /// 要跳转的目标页面（必须是 Widget）
  final String route;

  /// 文字样式（可选）
  final TextStyle? style;

  /// 是否显示下划线（默认 false）
  final bool underline;

  /// 路由是否可返回（默认 true，即使用 push；若为 false 则使用 pushReplacement）
  final bool canPop;

  final Color textColor;

  const TextNavigateButton({
    super.key,
    required this.text,
    required this.route,
    this.style,
    this.underline = false,
    this.canPop = true,
    this.textColor = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: textColor
    );

    return GestureDetector(
      onTap: () {
        if (canPop) {
          Navigator.of(context).pushNamed(route);
        } else {
          Navigator.of(context).pushReplacementNamed(route);
        }
      },
      child: Text(
          text,
          style: style ?? defaultStyle,
        )
    );
  }
}