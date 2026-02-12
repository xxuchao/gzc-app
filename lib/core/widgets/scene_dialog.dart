import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// 显示权限被拒绝的对话框
void showPermissionDeniedDialog(BuildContext context, {
  required String title,
  required String content,

}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 关闭对话框
            },
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: Text('去设置'),
          ),
        ],
      );
    },
  );
}