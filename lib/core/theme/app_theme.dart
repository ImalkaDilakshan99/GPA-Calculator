import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';

/// Centralized ThemeData configuration for the GPA Calculator application.
abstract final class AppTheme {
  /// Dark theme adhering to the centralized design system.
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryDark,
      onSecondaryContainer: AppColors.secondaryLight,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryDark,
      onTertiaryContainer: AppColors.tertiaryLight,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      outline: AppColors.border,
      surfaceContainer: AppColors.surfaceVariant,
      surfaceContainerHigh: AppColors.surfaceElevated,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: colorScheme,
      fontFamily: AppTextStyles.fontFamily,

      // ── AppBar Theme ───────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headlineMedium,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),

      // ── Card Theme ─────────────────────────────────────────────────
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusMd,
          side: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Button Themes ──────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusSm,
          ),
          padding: AppDimensions.paddingButton,
          textStyle: AppTextStyles.button,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusSm,
          ),
          padding: AppDimensions.paddingButton,
          textStyle: AppTextStyles.buttonSmall,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusLg,
        ),
      ),

      // ── Input Decoration Theme ─────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.lg,
          vertical: AppDimensions.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusSm,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusSm,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusSm,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusSm,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimensions.borderRadiusSm,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.labelMedium,
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 14,
        ),
      ),

      // ── Text Theme ─────────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleMedium,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ── Icon Theme ─────────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppDimensions.iconMd,
      ),

      // ── Divider Theme ──────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: AppDimensions.lg,
      ),
    );
  }
}

