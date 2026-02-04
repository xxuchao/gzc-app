import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

Future<bool?> showCustomStyledDialog({
  required BuildContext context,
  required String title,
  String content = "提示信息",
  Widget? contentWidget,
  String confirmText = '确定',
  String? cancelText = "取消", // 改为可空类型，null 表示单按钮
  Color? confirmButtonColor,
  bool barrierDismissible = false,
}) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      final primaryColor = confirmButtonColor ?? theme.colorScheme.primary;
      final textTheme = theme.textTheme;

      // 构建按钮的通用方法
      Widget buildTextButton({
        required String text,
        required VoidCallback onPressed,
        Color? textColor,
      }) {
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? primaryColor,
            padding: EdgeInsets.symmetric(vertical: Spacing.md),
          ),
          child: Text(text),
        );
      }

      List<Widget> actions;
      if (cancelText == null) {
        // 单按钮：居中显示
        actions = [
          Center(
            child: buildTextButton(
              text: confirmText,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
        ];
      } else {
        // 双按钮：左右平分
        actions = [
          Row(
            children: [
              Expanded(
                child: buildTextButton(
                  text: cancelText,
                  onPressed: () => Navigator.of(context).pop(false),
                  textColor: Colors.black87,
                ),
              ),
              SizedBox(width: Spacing.md),
              Expanded(
                child: buildTextButton(
                  text: confirmText,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ];
      }

      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(vertical:Spacing.cardGap, horizontal: Spacing.pageHorizontal),
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: Spacing.buttonPaddingV),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        content: contentWidget ?? Text(
          content,
          textAlign: TextAlign.center,
        ),
        // actionsPadding: EdgeInsets.all(Spacing.md),
        actionsPadding: EdgeInsets.fromLTRB(Spacing.pageHorizontal, 0, Spacing.pageHorizontal, Spacing.cardGap),
        actions: actions,
      );
    },
  );
}

/**
import 'package:your_app/utils/dialogs.dart'; // 引入上面的文件

ElevatedButton(
  onPressed: () async {
    final result = await showConfirmDialog(
      context: context,
      title: '删除确认',
      content: '此操作不可恢复，是否继续？',
      confirmText: '删除',
      cancelText: '再想想',
      // confirmButtonColor: Colors.red, // 可选：自定义按钮颜色
    );

    if (result == true) {
      // 执行删除逻辑
      print('用户确认删除');
    } else if (result == false) {
      print('用户取消');
    } else {
      print('用户点击外部关闭（仅当 barrierDismissible: true）');
    }
  },
  child: Text('删除'),
)
 */