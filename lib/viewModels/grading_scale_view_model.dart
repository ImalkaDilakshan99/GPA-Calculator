import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/models/grade_model.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

// ── Stream of all grading scales ─────────────────────────────────────
final gradingScalesStreamProvider =
    StreamProvider<List<GradingScaleEntity>>((ref) {
  final repo = ref.watch(gradingScaleRepositoryProvider);
  return repo.watchAllScales();
});

// ── Default fallback scale entity ────────────────────────────────────
final defaultFallbackScale = GradingScaleEntity(
  id: 1,
  name: 'United States — Standard 4.0 Scale',
  country: 'United States',
  maximumGpa: 4.0,
  scaleType: ScaleType.predefined,
  category: 'recommended',
  calculationType: 'gpa',
  minimumValue: 0.0,
  bestValue: 4.0,
  worstValue: 0.0,
  passingValue: 1.0,
  isHigherBetter: true,
  decimalPlaces: 2,
  isDefault: true,
  createdAt: DateTime(2024, 1, 1),
  updatedAt: DateTime(2024, 1, 1),
);

// ── Active Grading Scale Provider ────────────────────────────────────
final activeGradingScaleProvider = Provider<GradingScaleEntity>((ref) {
  final profileAsync = ref.watch(studentProfileStreamProvider);
  final profileScale = profileAsync.value?.gradingScale;
  if (profileScale != null) {
    return profileScale;
  }

  final scalesAsync = ref.watch(gradingScalesStreamProvider);
  return scalesAsync.maybeWhen(
    data: (scales) {
      if (scales.isEmpty) return defaultFallbackScale;
      final defaultScale = scales.where((s) => s.isDefault);
      if (defaultScale.isNotEmpty) {
        return defaultScale.first;
      }
      return scales.first;
    },
    orElse: () => defaultFallbackScale,
  );
});

// ── Active Grade Definitions for UI ──────────────────────────────────
final activeGradeDefinitionsProvider = Provider<List<GradeModel>>((ref) {
  final scale = ref.watch(activeGradingScaleProvider);
  if (scale.entries.isEmpty) {
    return gradeDefinitions;
  }

  return scale.entries.map((entry) {
    return GradeModel(
      grade: entry.grade,
      gradePoint: entry.gradePoint,
      colorValue: _computeGradeColor(entry, scale),
    );
  }).toList();
});

/// Intelligent color coding for grades across worldwide scales.
int _computeGradeColor(GradingScaleEntryEntity entry, GradingScaleEntity scale) {
  if (!entry.isPassing) {
    return 0xFF212121; // Dark / Fail
  }

  final range = (scale.bestValue - scale.worstValue).abs();
  if (range == 0.0) return 0xFF4CAF50;

  // Normalized score: 1.0 = best, 0.0 = worst
  final double score;
  if (scale.isHigherBetter) {
    score = ((entry.gradePoint - scale.worstValue) / range).clamp(0.0, 1.0);
  } else {
    score = ((scale.worstValue - entry.gradePoint) / range).clamp(0.0, 1.0);
  }

  if (score >= 0.85) return 0xFF4CAF50; // Green (Excellent)
  if (score >= 0.70) return 0xFF2196F3; // Blue (Very Good / Good)
  if (score >= 0.50) return 0xFFFF9800; // Amber (Above Average / Average)
  if (score >= 0.35) return 0xFFFFA726; // Light Orange (Pass threshold)
  return 0xFFF44336; // Red (Near fail)
}

// ── Search & Filter State Providers ──────────────────────────────────
class GradingScaleSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setSearchQuery(String query) {
    state = query;
  }
}

final gradingScaleSearchQueryProvider =
    NotifierProvider<GradingScaleSearchNotifier, String>(
  GradingScaleSearchNotifier.new,
);

class GradingScaleCategoryNotifier extends Notifier<String> {
  @override
  String build() => 'all';

  void setCategory(String category) {
    state = category;
  }
}

final gradingScaleCategoryProvider =
    NotifierProvider<GradingScaleCategoryNotifier, String>(
  GradingScaleCategoryNotifier.new,
);

// ── Filtered Scales for UI ───────────────────────────────────────────
final filteredGradingScalesProvider =
    Provider<AsyncValue<List<GradingScaleEntity>>>((ref) {
  final scalesAsync = ref.watch(gradingScalesStreamProvider);
  final category = ref.watch(gradingScaleCategoryProvider);
  final query = ref.watch(gradingScaleSearchQueryProvider).trim().toLowerCase();

  return scalesAsync.whenData((scales) {
    return scales.where((scale) {
      // 1. Category Filter
      if (category != 'all') {
        if (category == 'custom') {
          if (!scale.isCustom) return false;
        } else if (category == 'recommended') {
          if (scale.category != 'recommended') return false;
        } else if (category == 'international') {
          if (scale.category != 'international') return false;
        } else if (category == 'country') {
          if (scale.category != 'country' && scale.category != 'recommended') return false;
        } else if (category == 'university') {
          if (scale.category != 'university') return false;
        }
      }

      // 2. Search Query Filter
      if (query.isNotEmpty) {
        final inName = scale.name.toLowerCase().contains(query);
        final inCountry = (scale.country ?? '').toLowerCase().contains(query);
        final inUniversity = (scale.university ?? '').toLowerCase().contains(query);
        final inDesc = (scale.description ?? '').toLowerCase().contains(query);
        final inMaxGpa = scale.maximumGpa.toString().contains(query);
        final inScaleType = scale.scaleType.name.toLowerCase().contains(query);
        final inGrade = scale.entries.any(
          (e) => e.grade.toLowerCase() == query || e.grade.toLowerCase().contains(query),
        );

        if (!inName && !inCountry && !inUniversity && !inDesc && !inMaxGpa && !inScaleType && !inGrade) {
          return false;
        }
      }

      return true;
    }).toList();
  });
});

// ── Actions ──────────────────────────────────────────────────────────

/// Sets the active grading scale, offering a choice to recalculate existing records or preserve them.
Future<void> setActiveGradingScale(
  WidgetRef ref,
  int scaleId, {
  required bool recalculateExisting,
}) async {
  final repo = ref.read(gradingScaleRepositoryProvider);
  await repo.setActiveGradingScale(
    scaleId,
    recalculateExisting: recalculateExisting,
  );
}

/// Creates a new custom grading scale in the database.
Future<int> createCustomGradingScale(
  WidgetRef ref,
  GradingScaleEntity scale,
) {
  final repo = ref.read(gradingScaleRepositoryProvider);
  return repo.createScale(scale);
}

/// Updates an existing custom grading scale.
Future<void> updateCustomGradingScale(
  WidgetRef ref,
  GradingScaleEntity scale,
) {
  final repo = ref.read(gradingScaleRepositoryProvider);
  return repo.updateScale(scale);
}

/// Deletes a custom grading scale.
Future<void> deleteCustomGradingScale(
  WidgetRef ref,
  int scaleId,
) {
  final repo = ref.read(gradingScaleRepositoryProvider);
  return repo.deleteScale(scaleId);
}
