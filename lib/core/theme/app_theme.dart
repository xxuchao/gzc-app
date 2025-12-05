// lib/core/theme/app_theme.dart
import 'colors.dart';
import 'package:flutter/material.dart';
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
    onSurfaceVariant: secondaryTextColor
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
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(primaryColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
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
    subtitleTextStyle: bodyMedium.copyWith(color: secondaryTextColor)
  )
);