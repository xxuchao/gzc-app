import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<String?> showCustomPopupMenu({
  required BuildContext triggerContext,
  required List<PopupOption> options, // 👈 改为 List<PopupOption>
  int menuShowCount = 5,
  double? menuWidth,
  Alignment menuTextAlign = Alignment.centerLeft,
}) async {
  final RenderBox? buttonBox = triggerContext.findRenderObject() as RenderBox?;
  if (buttonBox == null || !buttonBox.attached) return null;

  final overlay = Overlay.of(triggerContext);
  final overlayBox = overlay.context.findRenderObject() as RenderBox;
  final screenSize = overlayBox.size;

  final buttonTopLeft = buttonBox.localToGlobal(Offset.zero, ancestor: overlayBox);

  final popHeight = 46.h;
  final double menuHeight = options.length <= menuShowCount
      ? popHeight * options.length + 16
      : popHeight * menuShowCount + 16;

  final width = menuWidth ?? buttonBox.size.width;

  // 构建菜单项
  final List<PopupMenuEntry<String>> menuItems = options.map((option) {
    return PopupMenuItem<String>(
      value: option.key,
      enabled: option.enabled, // 👈 控制是否可点击
      height: popHeight,
      child: Align(
        alignment: menuTextAlign,
        child: Text(
          option.label,
          style: TextStyle(
            color: option.enabled
                ? null // 使用默认颜色（通常是黑色）
                : Colors.grey, // 灰色表示不可用
          ),
        ),
      ),
    );
  }).toList();

  final String? result = await showMenu<String>(
    context: triggerContext,
    position: RelativeRect.fromRect(
      Rect.fromLTWH(
        buttonTopLeft.dx,
        buttonTopLeft.dy + buttonBox.size.height + 8,
        width,
        0,
      ),
      Offset.zero & screenSize,
    ),
    items: menuItems,
    elevation: 2,
    constraints: BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: menuHeight,
      maxHeight: menuHeight,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    color: Colors.white,
  );

  return result;
}

class PopupOption {
  final String key;
  final String label;
  final bool enabled;

  PopupOption({
    required this.key,
    required this.label,
    this.enabled = true,
  });
}