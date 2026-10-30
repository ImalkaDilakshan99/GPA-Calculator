import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_dimensions.dart';

/// Centralized BoxDecoration configurations for cards, containers, and inputs.
abstract final class AppDecorations {
  /// Standard surface card decoration.
  static final BoxDecoration card = BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppDimensions.borderRadiusMd,
    border: Border.all(color: AppColors.borderSubtle, width: 1),
  );

  /// Elevated / interactive card decoration.
  static final BoxDecoration cardElevated = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: AppDimensions.borderRadiusMd,
    border: Border.all(color: AppColors.border, width: 1),
  );

  /// Stat tile container decoration (dashboard metrics).
  static final BoxDecoration statTile = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: AppDimensions.borderRadiusMd,
    border: Border.all(color: AppColors.borderSubtle, width: 1),
  );

  /// Hero card banner decoration (e.g. in AddSubject).
  static const BoxDecoration heroCard = BoxDecoration(
    color: AppColors.primary,
    borderRadius: AppDimensions.borderRadiusMd,
  );

  /// Circular hero icon container (e.g. in SemesterAdd).
  static const BoxDecoration heroCircle = BoxDecoration(
    color: AppColors.primary,
    shape: BoxShape.circle,
  );

  /// Counter container (e.g. credits counter in AddSubject).
  static final BoxDecoration counterBox = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: AppDimensions.borderRadiusMd,
    border: Border.all(color: AppColors.border, width: 1),
  );

  /// Circular grade indicator badge.
  static BoxDecoration gradeBadge(Color color) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }

  /// Rounded rectangle grade badge (e.g. in semester subject list).
  static BoxDecoration gradeBadgeRounded(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: AppDimensions.borderRadiusSm,
    );
  }

  /// GPA status pill badge with tinted background.
  static BoxDecoration gpaStatusPill(Color statusColor) {
    return BoxDecoration(
      color: statusColor.withValues(alpha: 0.15),
      borderRadius: AppDimensions.borderRadiusMd,
      border: Border.all(color: statusColor.withValues(alpha: 0.3)),
    );
  }

  /// Navigation / Menu bar capsule container.
  static final BoxDecoration navBar = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: AppDimensions.borderRadiusFull,
    border: Border.all(color: AppColors.borderSubtle, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 16,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Active nav bar item indicator.
  static const BoxDecoration navBarActiveItem = BoxDecoration(
    color: AppColors.primary,
    borderRadius: AppDimensions.borderRadiusXl,
  );
}

