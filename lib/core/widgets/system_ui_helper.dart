import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gzc_app/core/theme/colors.dart';

/// 系统UI辅助类，用于动态设置系统导航栏颜色
class SystemUIHelper {
  /// 设置系统导航栏为白色
  static void setLightNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavBarLight,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// 设置系统导航栏为黑色
  static void setDarkNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavBarDark,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// 设置系统导航栏为自定义颜色
  static void setCustomNavigationBar({
    required Color color,
    required Brightness iconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness: iconBrightness,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
      ),
    );
  }

  /// 设置透明导航栏（全面屏模式）
  static void setTransparentNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}