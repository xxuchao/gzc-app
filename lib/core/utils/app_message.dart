import 'package:flutter/material.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:toastification/toastification.dart';

/// 提示:
///  AppMessage.info("content")

enum AppMessagePosition {
  top,
  bottom,
}

class AppMessage {
  // 存储当前显示的toast实例
  static ToastificationItem? _currentToast;
  
  static OverlayState? get _overlayState =>
      AppRouter.navigatorKey.currentState?.overlay;

  static Alignment _alignment(AppMessagePosition position) {
    return position == AppMessagePosition.top
        ? Alignment.topCenter
        : Alignment.bottomCenter;
  }

  /// 关闭当前显示的toast
  static void _dismissCurrent() {
    if (_currentToast != null) {
      toastification.dismiss(_currentToast!);
      _currentToast = null;
    }
  }

  /// 关闭所有toast
  static void dismissAll() {
    toastification.dismissAll();
    _currentToast = null;
  }

  static ToastificationItem? info(
    String message, {
    String? description,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      title: message,
      description: description,
      type: ToastificationType.info,
      position: position,
      duration: duration,
    );
  }

  static ToastificationItem? success(
    String message, {
    String? description,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      title: message,
      description: description,
      type: ToastificationType.success,
      position: position,
      duration: duration,
    );
  }

  static ToastificationItem? error(
    String message, {
    String? description,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      title: message,
      description: description,
      type: ToastificationType.error,
      position: position,
      duration: duration,
    );
  }

  static ToastificationItem? warning(
    String message, {
    String? description,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      title: message,
      description: description,
      type: ToastificationType.warning,
      position: position,
      duration: duration,
    );
  }

  static ToastificationItem? show({
    required String title,
    String? description,
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
    bool showProgressBar = false,
    bool closeOnClick = false,
    bool dragToClose = true,
    bool pauseOnHover = true,
    bool applyBlurEffect = false,
    bool replacePrevious = true, // 新增参数：是否替换之前的toast
  }) {
    final overlayState = _overlayState;
    if (overlayState == null) return null;

    // 如果需要替换之前的toast，先关闭当前显示的
    if (replacePrevious) {
      _dismissCurrent();
    }

    final toast = toastification.show(
      overlayState: overlayState,
      type: type,
      style: style,
      alignment: _alignment(position),
      autoCloseDuration: duration,
      title: Text(title),
      description:
          description == null ? null : Text(description, maxLines: 3),
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      pauseOnHover: pauseOnHover,
      applyBlurEffect: applyBlurEffect,
    );

    // 保存当前toast实例
    if (replacePrevious) {
      _currentToast = toast;
    }

    return toast;
  }

  /// 显示多个toast（不会自动关闭之前的）
  static ToastificationItem? showMultiple({
    required String title,
    String? description,
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    AppMessagePosition position = AppMessagePosition.top,
    Duration duration = const Duration(seconds: 3),
    bool showProgressBar = false,
    bool closeOnClick = false,
    bool dragToClose = true,
    bool pauseOnHover = true,
    bool applyBlurEffect = false,
  }) {
    return show(
      title: title,
      description: description,
      type: type,
      style: style,
      position: position,
      duration: duration,
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      pauseOnHover: pauseOnHover,
      applyBlurEffect: applyBlurEffect,
      replacePrevious: false, // 不替换之前的toast
    );
  }

  /// 显示加载提示
  static ToastificationItem? loading(
    String message, {
    String? description,
    AppMessagePosition position = AppMessagePosition.top,
  }) {
    return show(
      title: message,
      description: description,
      type: ToastificationType.info,
      position: position,
      duration: const Duration(days: 1), // 设置很长的时间，需要手动关闭
      showProgressBar: true,
      closeOnClick: false,
      dragToClose: false,
      pauseOnHover: false,
    );
  }

  /// 快捷方法：复制成功提示
  static ToastificationItem? copySuccess([String? customMessage]) {
    return success(customMessage ?? '已复制到剪贴板');
  }

  /// 快捷方法：网络错误提示
  static ToastificationItem? networkError([String? customMessage]) {
    return error(
      customMessage ?? '网络连接失败',
      description: '请检查网络连接后重试',
    );
  }

  /// 快捷方法：操作成功提示
  static ToastificationItem? operationSuccess([String? customMessage]) {
    return success(customMessage ?? '操作成功');
  }

  /// 快捷方法：操作失败提示
  static ToastificationItem? operationFailed([String? customMessage]) {
    return error(customMessage ?? '操作失败，请重试');
  }
}
