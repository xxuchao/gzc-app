import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';

/// 底部安全区域组件，用于设置底部导航栏区域的背景颜色
class SafeAreaBottom extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  
  const SafeAreaBottom({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Column(
      children: [
        Expanded(child: child),
        if (bottomPadding > 0)
          Container(
            height: bottomPadding,
            color: backgroundColor ?? surfaceColor,
          ),
      ],
    );
  }
}