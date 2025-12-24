
import 'package:flutter/material.dart';

/// 字体样式预设 - 基于 Material Design 3 (Material You)
///
/// 所有 fontSize 使用逻辑像素（dp），自动适配系统字体缩放（textScaleFactor）
/// 字号和行高参考官方规范：https://m3.material.io/styles/typography/type-scale-tokens

// ============ Display 展示文字 ============
final displayLarge = TextStyle(
  fontSize: 57.0,
  fontWeight: FontWeight.w400,
  letterSpacing: -0.25,
  height: 64 / 57, // ≈ 1.1228
);

final displayMedium = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w400,
  height: 52 / 45, // ≈ 1.1556
);

final displaySmall = TextStyle(
  fontSize: 36.0,
  fontWeight: FontWeight.w400,
  height: 44 / 36, // ≈ 1.2222
);

// ============ Headline 页面标题 ============
final headlineLarge = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w600,
  height: 40 / 32, // = 1.25
);

final headlineMedium = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w600,
  height: 36 / 28, // ≈ 1.2857
);

final headlineSmall = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
  height: 32 / 24, // ≈ 1.3333
);

// ============ Title 卡片/列表标题 ============
final titleLarge = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w500,
  height: 28 / 22, // ≈ 1.2727
);

final titleMedium = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
  height: 24 / 16, // = 1.5
);

final titleSmall = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 20 / 14, // ≈ 1.4286
);

// ============ Body 正文内容 ============
final bodyLarge = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  height: 24 / 16, // = 1.5
);

final bodyMedium = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
  height: 20 / 14, // ≈ 1.4286
);

final bodySmall = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  height: 16 / 12, // ≈ 1.3333
);

// ============ Label 按钮/标签 ============
final labelLarge = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
  height: 20 / 14, // ≈ 1.4286
);

final labelMedium = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 16 / 12, // ≈ 1.3333
);

final labelSmall = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  height: 16 / 11, // ≈ 1.4545
);