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
  static OverlayState? get _overlayState =>
      AppRouter.navigatorKey.currentState?.overlay;

  static Alignment _alignment(AppMessagePosition position) {
    return position == AppMessagePosition.top
        ? Alignment.topCenter
        : Alignment.bottomCenter;
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
  }) {
    final overlayState = _overlayState;
    if (overlayState == null) return null;

    return toastification.show(
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
  }
}
