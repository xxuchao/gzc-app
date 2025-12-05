import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 间距预设 - 基于 designSize: 390x844
/// 使用 8pt 网格系统

class Spacing {
  Spacing._();

  // ============ 基础间距 ============
  /// 4dp - 极小间距（图标与文字间距）
  static double get xs => 4.w;
  
  /// 8dp - 小间距（紧凑元素间距）
  static double get sm => 8.w;
  
  /// 12dp - 中小间距
  static double get md => 12.w;
  
  /// 16dp - 标准间距（常用内边距）
  static double get lg => 16.w;
  
  /// 20dp - 中大间距
  static double get xl => 20.w;
  
  /// 24dp - 大间距（区块间距）
  static double get xxl => 24.w;
  
  /// 32dp - 超大间距（页面区域分隔）
  static double get xxxl => 32.w;

  // ============ 页面边距 ============
  /// 16dp - 页面水平边距
  static double get pageHorizontal => 14.w;
  
  /// 20dp - 页面顶部边距
  static double get pageTop => 20.h;
  
  /// 24dp - 页面底部边距（考虑底部安全区）
  static double get pageBottom => 24.h;

  // ============ 组件间距 ============
  /// 8dp - 列表项垂直间距
  static double get listItemGap => 8.h;
  
  /// 12dp - 卡片内边距
  static double get cardPadding => 12.w;
  
  /// 16dp - 卡片间距
  static double get cardGap => 16.h;
  
  /// 8dp - 按钮内水平边距
  static double get buttonPaddingH => 16.w;
  
  /// 12dp - 按钮内垂直边距
  static double get buttonPaddingV => 12.h;
  
  /// 12dp - 输入框内边距
  static double get inputPadding => 12.w;

  // ============ 圆角 ============
  /// 4dp - 小圆角（按钮、标签）
  static double get radiusSm => 4.r;
  
  /// 8dp - 中圆角（卡片、输入框）
  static double get radiusMd => 8.r;
  
  /// 12dp - 大圆角（弹窗、底部弹出）
  static double get radiusLg => 12.r;
  
  /// 16dp - 超大圆角
  static double get radiusXl => 16.r;
  
  /// 圆形
  static double get radiusFull => 999.r;

  // ============ 图标尺寸 ============
  /// 16dp - 小图标
  static double get iconSm => 16.w;
  
  /// 20dp - 中图标
  static double get iconMd => 20.w;
  
  /// 24dp - 标准图标
  static double get iconLg => 24.w;
  
  /// 32dp - 大图标
  static double get iconXl => 32.w;
  
  /// 48dp - 超大图标
  static double get iconXxl => 48.w;
}