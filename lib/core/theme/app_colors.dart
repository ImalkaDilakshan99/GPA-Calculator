import 'package:flutter/material.dart';

/// Centralized color palette for the GPA Calculator application.
///
/// Source of truth derived from the design system palette:
/// - Primary: #2B2BEE
/// - Secondary: #A5A5FF
/// - Tertiary: #9F2100
/// - Neutral: #777683
/// - Background: #12131C
/// - Surface: #1F1F29
/// - Surface Container / Variant: #292934
abstract final class AppColors {
  // ── Brand / Core Palette ───────────────────────────────────────────
  static const Color primary = Color(0xFF2B2BEE);
  static const Color primaryLight = Color(0xFFC0C1FF);
  static const Color primaryDark = Color(0xFF0A00AB);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFA5A5FF);
  static const Color secondaryLight = Color(0xFFC2C1FF);
  static const Color secondaryDark = Color(0xFF3D3C8F);
  static const Color onSecondary = Color(0xFF12131C);

  static const Color tertiary = Color(0xFF9F2100);
  static const Color tertiaryLight = Color(0xFFFFB4A3);
  static const Color tertiaryDark = Color(0xFF621100);
  static const Color onTertiary = Color(0xFFFFFFFF);

  // ── Background & Surfaces ──────────────────────────────────────────
  static const Color background = Color(0xFF12131C);
  static const Color surface = Color(0xFF1F1F29);
  static const Color surfaceVariant = Color(0xFF292934);
  static const Color surfaceElevated = Color(0xFF323240);

  // ── Neutral & Borders ──────────────────────────────────────────────
  static const Color neutral = Color(0xFF777683);
  static const Color neutralDark = Color(0xFF2F2F3A);
  static const Color neutralLight = Color(0xFFABAAB7);
  static const Color border = Color(0xFF3F3E4D);
  static const Color borderSubtle = Color(0xFF292934);
  static const Color borderAccent = Color(0xFF7168F6);

  // ── Typography ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFE3E1EF);
  static const Color textSecondary = Color(0xFF918F9D);
  static const Color textMuted = Color(0xFF777683);
  static const Color textDisabled = Color(0xFF5E5D69);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textInverted = Color(0xFF12131C);

  // ── Semantic / Functional (GPA Status & Grades) ────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF42A5F5);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFA726);
  static const Color error = Color(0xFFF44336);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color gradeF = Color(0xFF212121);
}

