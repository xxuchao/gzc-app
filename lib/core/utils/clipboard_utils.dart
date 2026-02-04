import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 剪贴板工具类
class ClipboardUtils {
  /// 复制文本到剪贴板
  /// 
  /// [text] 要复制的文本
  /// [context] 上下文，用于显示提示信息（可选）
  /// [showMessage] 是否显示复制成功的提示信息，默认为true
  /// [message] 自定义提示信息，默认为"已复制到剪贴板"
  /// 
  /// 返回 Future<bool> 表示复制是否成功
  static Future<bool> copyText(
    String text, {
    BuildContext? context,
    bool showMessage = true,
    String? message,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      
      // 显示成功提示
      if (showMessage && context != null) {
        final snackBar = SnackBar(
          content: Text(message ?? '已复制到剪贴板'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
      return true;
    } catch (e) {
      // 显示错误提示
      if (showMessage && context != null) {
        final snackBar = SnackBar(
          content: const Text('复制失败'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
      return false;
    }
  }

  /// 从剪贴板获取文本
  /// 
  /// 返回 Future<String?> 剪贴板中的文本，如果获取失败返回null
  static Future<String?> getText() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      return clipboardData?.text;
    } catch (e) {
      return null;
    }
  }

  /// 检查剪贴板是否有文本内容
  /// 
  /// 返回 Future<bool> 是否有文本内容
  static Future<bool> hasText() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      return clipboardData?.text?.isNotEmpty ?? false;
    } catch (e) {
      return false;
    }
  }

  /// 清空剪贴板
  /// 
  /// [context] 上下文，用于显示提示信息（可选）
  /// [showMessage] 是否显示清空成功的提示信息，默认为true
  /// 
  /// 返回 Future<bool> 表示清空是否成功
  static Future<bool> clear({
    BuildContext? context,
    bool showMessage = true,
  }) async {
    try {
      await Clipboard.setData(const ClipboardData(text: ''));
      
      // 显示成功提示
      if (showMessage && context != null) {
        final snackBar = SnackBar(
          content: const Text('剪贴板已清空'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
      return true;
    } catch (e) {
      // 显示错误提示
      if (showMessage && context != null) {
        final snackBar = SnackBar(
          content: const Text('清空失败'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
      return false;
    }
  }

  /// 复制并显示自定义Toast提示
  /// 
  /// [text] 要复制的文本
  /// [context] 上下文
  /// [successMessage] 成功提示信息
  /// [errorMessage] 失败提示信息
  /// [duration] 提示显示时长
  /// 
  /// 返回 Future<bool> 表示复制是否成功
  static Future<bool> copyWithCustomMessage(
    String text,
    BuildContext context, {
    String? successMessage,
    String? errorMessage,
    Duration duration = const Duration(seconds: 2),
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      
      final snackBar = SnackBar(
        content: Text(successMessage ?? '复制成功'),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      return true;
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(errorMessage ?? '复制失败'),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
      return false;
    }
  }

  /// 复制多行文本（保持格式）
  /// 
  /// [lines] 文本行列表
  /// [separator] 行分隔符，默认为换行符
  /// [context] 上下文，用于显示提示信息（可选）
  /// [showMessage] 是否显示复制成功的提示信息，默认为true
  /// 
  /// 返回 Future<bool> 表示复制是否成功
  static Future<bool> copyLines(
    List<String> lines, {
    String separator = '\n',
    BuildContext? context,
    bool showMessage = true,
  }) async {
    final text = lines.join(separator);
    return copyText(
      text,
      context: context,
      showMessage: showMessage,
      message: '已复制${lines.length}行文本',
    );
  }

  /// 复制键值对格式的文本
  /// 
  /// [data] 键值对数据
  /// [separator] 键值分隔符，默认为": "
  /// [lineSeparator] 行分隔符，默认为换行符
  /// [context] 上下文，用于显示提示信息（可选）
  /// [showMessage] 是否显示复制成功的提示信息，默认为true
  /// 
  /// 返回 Future<bool> 表示复制是否成功
  static Future<bool> copyKeyValuePairs(
    Map<String, String> data, {
    String separator = ': ',
    String lineSeparator = '\n',
    BuildContext? context,
    bool showMessage = true,
  }) async {
    final lines = data.entries
        .map((entry) => '${entry.key}$separator${entry.value}')
        .toList();
    
    return copyLines(
      lines,
      separator: lineSeparator,
      context: context,
      showMessage: showMessage,
    );
  }
}