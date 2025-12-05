import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 字体样式预设 - 基于 designSize: 390x844
/// 
/// Display: 用于大型展示文字（如启动页、大标题）
/// Headline: 用于页面标题
/// Title: 用于卡片标题、列表项标题
/// Body: 用于正文内容
/// Label: 用于按钮、标签、辅助文字

// ============ Display 展示文字 ============
final displayLarge = TextStyle(
  fontSize: 57.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: -0.25,
  height: 1.12,
);

final displayMedium = TextStyle(
  fontSize: 45.sp,
  fontWeight: FontWeight.w400,
  height: 1.16,
);

final displaySmall = TextStyle(
  fontSize: 36.sp,
  fontWeight: FontWeight.w400,
  height: 1.22,
);

// ============ Headline 页面标题 ============
final headlineLarge = TextStyle(
  fontSize: 32.sp,
  fontWeight: FontWeight.w600,
  height: 1.25,
);

final headlineMedium = TextStyle(
  fontSize: 28.sp,
  fontWeight: FontWeight.w600,
  height: 1.29,
);

final headlineSmall = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.w600,
  height: 1.33,
);

// ============ Title 卡片/列表标题 ============
final titleLarge = TextStyle(
  fontSize: 22.sp,
  fontWeight: FontWeight.w500,
  height: 1.27,
);

final titleMedium = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
  height: 1.50,
);

final titleSmall = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 1.43,
);

// ============ Body 正文内容 ============
final bodyLarge = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  height: 1.50,
);

final bodyMedium = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  height: 1.43,
);

final bodySmall = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  height: 1.33,
);

// ============ Label 按钮/标签 ============
final labelLarge = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 1.43,
);

final labelMedium = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 1.33,
);

final labelSmall = TextStyle(
  fontSize: 11.sp,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 1.45,
);