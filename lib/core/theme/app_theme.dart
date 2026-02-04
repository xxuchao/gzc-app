// lib/core/theme/app_theme.dart
import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gzc_app/core/theme/text_styles.dart';

final appLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    surface: surfaceColor,
    error: tagDangerColor,
    onPrimary: textColor,
    onSurface: textColor,
    onSurfaceVariant: secondaryTextColor,
  ),
  textTheme: TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  ),
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: surfaceColor,
    foregroundColor: textColor,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      
      systemNavigationBarColor: surfaceColor, // 底部导航栏颜色
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(primaryColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      splashFactory: InkRipple.splashFactory, // 使用 InkRipple
      overlayColor: WidgetStateProperty.all(Colors.blue.withValues(alpha: 0.3)), 
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surfaceColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: secondaryTextColor,
    selectedLabelStyle: labelMedium,
    unselectedLabelStyle: labelMedium,
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: titleSmall.copyWith(color: textColor),
    subtitleTextStyle: bodyMedium.copyWith(color: secondaryTextColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: bodyMedium,
    labelStyle: bodyMedium
  )
);