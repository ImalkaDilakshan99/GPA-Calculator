import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';

/// Centralized typography definitions for the GPA Calculator application.
///
/// Follows the design system specification:
/// - Headline (Inter, Bold)
/// - Body (Inter, Regular/Medium)
/// - Label (Inter, Medium/SemiBold)
abstract final class AppTextStyles {
  static const String fontFamily = 'Inter';

  // ── Display Styles ─────────────────────────────────────────────────
  /// Extra large credit counter (50pt bold in AddSubject)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
  );

  /// Large circular CGPA indicator (42pt bold in CircularProgressBar)
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: -0.5,
  );

  /// Term GPA indicator (32pt bold in SemesterCard & Semester detail)
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // ── Headline Styles ────────────────────────────────────────────────
  /// Main screen title (24pt bold, e.g. 'Dashboard')
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
  );

  /// Section headers (20pt bold, e.g. 'Semester History')
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Sub-headers (18pt bold, e.g. 'Welcome back', 'Subjects')
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // ── Title Styles ───────────────────────────────────────────────────
  /// Metric values & medium card titles (16pt semi-bold)
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Small card / row titles (14pt semi-bold)
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── Body Styles ────────────────────────────────────────────────────
  /// Standard body text (16pt regular)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// Secondary body text (14pt regular, muted color)
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  /// Caption / helper text (12pt regular)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // ── Label & Button Styles ──────────────────────────────────────────
  /// Main action button label (18-20pt bold)
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
  );

  /// Secondary / Small button label (14pt bold)
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onPrimary,
  );

  /// Input label & chip text (14pt medium)
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  /// Overline / progress bar header label (11pt medium)
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  /// Status badge text (13pt semi-bold)
  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
}

