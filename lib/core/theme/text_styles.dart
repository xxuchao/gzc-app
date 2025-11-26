import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );
  }

  // 或直接返回 TextStyle（不依赖 context）
  static final titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );
}