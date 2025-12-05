import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 设备信息工具类
/// 提供屏幕尺寸、安全区域、设备类型等信息
class DeviceUtils {
  DeviceUtils._();

  static late MediaQueryData _mediaQuery;
  static late EdgeInsets _padding;
  static late EdgeInsets _viewInsets;
  static late EdgeInsets _viewPadding;

  /// 初始化设备信息（在 MaterialApp 的 builder 中调用）
  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _padding = _mediaQuery.padding;
    _viewInsets = _mediaQuery.viewInsets;
    _viewPadding = _mediaQuery.viewPadding;
  }

  // ============ 屏幕尺寸 ============
  /// 屏幕宽度（物理像素）
  static double get screenWidth => _mediaQuery.size.width;

  /// 屏幕高度（物理像素）
  static double get screenHeight => _mediaQuery.size.height;

  /// 屏幕宽度（适配后）
  static double get screenWidthDp => 1.sw;

  /// 屏幕高度（适配后）
  static double get screenHeightDp => 1.sh;

  /// 设备像素比
  static double get devicePixelRatio => _mediaQuery.devicePixelRatio;

  // ============ 安全区域 ============
  /// 顶部安全区域高度（状态栏）
  static double get safeTop => _padding.top;

  /// 底部安全区域高度（底部导航条/Home Indicator）
  static double get safeBottom => _padding.bottom;

  /// 左侧安全区域
  static double get safeLeft => _padding.left;

  /// 右侧安全区域
  static double get safeRight => _padding.right;

  /// 安全区域内边距
  static EdgeInsets get safePadding => _padding;

  /// 可用屏幕高度（减去安全区域）
  static double get safeHeight => screenHeight - safeTop - safeBottom;

  /// 可用屏幕宽度（减去安全区域）
  static double get safeWidth => screenWidth - safeLeft - safeRight;

  // ============ 键盘相关 ============
  /// 键盘高度
  static double get keyboardHeight => _viewInsets.bottom;

  /// 键盘是否显示
  static bool get isKeyboardVisible => _viewInsets.bottom > 0;

  // ============ 视图内边距 ============
  /// 视图内边距（包含键盘）
  static EdgeInsets get viewInsets => _viewInsets;

  /// 视图内边距（不受键盘影响）
  static EdgeInsets get viewPadding => _viewPadding;

  // ============ 设备类型判断 ============
  /// 是否是 iOS 设备
  static bool get isIOS => Platform.isIOS;

  /// 是否是 Android 设备
  static bool get isAndroid => Platform.isAndroid;

  /// 是否是手机（宽度 < 600）
  static bool get isPhone => screenWidth < 600;

  /// 是否是平板（宽度 >= 600）
  static bool get isTablet => screenWidth >= 600;

  /// 是否是横屏
  static bool get isLandscape => screenWidth > screenHeight;

  /// 是否是竖屏
  static bool get isPortrait => screenWidth <= screenHeight;

  // ============ 状态栏/导航栏 ============
  /// 状态栏高度
  static double get statusBarHeight => safeTop;

  /// 底部导航栏高度（Home Indicator）
  static double get bottomNavBarHeight => safeBottom;

  /// AppBar 默认高度
  static double get appBarHeight => kToolbarHeight;

  /// BottomNavigationBar 默认高度
  static double get bottomBarHeight => kBottomNavigationBarHeight;

  // ============ 常用组合高度 ============
  /// AppBar + 状态栏高度
  static double get appBarWithStatusHeight => appBarHeight + statusBarHeight;

  /// BottomNavigationBar + 底部安全区高度
  static double get bottomBarWithSafeHeight => bottomBarHeight + safeBottom;

  /// 内容区域可用高度（减去 AppBar、状态栏、底部导航栏、安全区）
  static double get contentHeight =>
      screenHeight - appBarWithStatusHeight - bottomBarWithSafeHeight;

  // ============ 调试信息 ============
  /// 打印设备信息
  static void printDeviceInfo() {
    debugPrint('========== Device Info ==========');
    debugPrint('Screen: ${screenWidth.toStringAsFixed(1)} x ${screenHeight.toStringAsFixed(1)}');
    debugPrint('Safe Area: top=$safeTop, bottom=$safeBottom, left=$safeLeft, right=$safeRight');
    debugPrint('Device Pixel Ratio: $devicePixelRatio');
    debugPrint('Platform: ${isIOS ? "iOS" : "Android"}');
    debugPrint('Device Type: ${isPhone ? "Phone" : "Tablet"}');
    debugPrint('Orientation: ${isLandscape ? "Landscape" : "Portrait"}');
    debugPrint('=================================');
  }
}
