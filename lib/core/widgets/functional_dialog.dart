// lib/widgets/functional_dialog.dart
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

/// 功能性弹窗：高度自定义，关闭逻辑由调用者控制
///
/// - [title]：标题（可传 Text 或 RichText）
/// - [content]：自定义内容区域（任意 Widget）
/// - [onCloseRequest]：点击右上角 × 时的回调（调用者决定是否关闭）
/// - [primaryAction]：主按钮配置（可选）
/// - [secondaryAction]：次按钮配置（可选）
/// - 若两个按钮都为空，则只显示关闭按钮
void showFunctionalDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  VoidCallback? onCloseRequest, // 点击 × 的回调
  DialogAction? primaryAction,
  DialogAction? secondaryAction,
  Color backgroundColor = Colors.white,
  double borderRadius = 16,
  showCloseButton = true, // 是否显示关闭按钮
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // 防止点击遮罩关闭（由调用者控制）
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(padding: EdgeInsets.all(Spacing.md), child: SizedBox(width: double.maxFinite, child: Center(child: title,))),
                if (showCloseButton) Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close),
                    iconSize: Spacing.iconMd,
                    onPressed: () => Navigator.of(context).pop(),
                  )
                )
              ],
            ),
            // 内容区域
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal, vertical: Spacing.cardPadding),
                child: content,
              ),
            ),
            // 按钮区域（如果有的话）
            if (primaryAction != null || secondaryAction != null)
              Padding(
                padding: EdgeInsets.fromLTRB(Spacing.pageHorizontal, 0, Spacing.pageHorizontal, Spacing.cardPadding),
                child: Row(
                  spacing: Spacing.lg,
                  children: [
                    if (secondaryAction != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: secondaryAction.onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: secondaryAction.textColor ?? Colors.black87,
                            // padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // 可选：圆角
                            ),
                          ),
                          child: Text(secondaryAction.text),
                        ),
                      ),
                    if (primaryAction != null)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: primaryAction.onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            // padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(primaryAction.text),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}

/// 按钮配置类
class DialogAction {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;

  const DialogAction({
    required this.text,
    this.onPressed,
    this.textColor,
  });
}