import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/view/pages/add_subject.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class SemesterView extends ConsumerWidget {
  final SemesterEntity semester;

  const SemesterView({super.key, required this.semester});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch subjects for this semester reactively from the database
    final subjectsAsync = ref.watch(semesterSubjectsStreamProvider(semester.id));

    return subjectsAsync.when(
      data: (subjects) => _buildContent(context, ref, subjects),
      loading: () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text(semester.name, style: AppTextStyles.headlineMedium),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text(semester.name, style: AppTextStyles.headlineMedium),
        ),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<SemesterSubjectEntity> subjects,
  ) {
    final gpaResult = ref.watch(semesterGpaProvider(subjects));
    final totalCredits = gpaResult.totalCredits;
    final currentGpa = gpaResult.gpa;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: AppDimensions.iconSm),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              semester.name,
              style: AppTextStyles.headlineMedium,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                color: AppColors.error,
                tooltip: 'Delete Semester',
                onPressed: () => _confirmDeleteSemesterDialog(context, ref),
              ),
            ],
          ),

          // Header Section
          SliverToBoxAdapter(
            child: Padding(
              padding: AppDimensions.paddingScreenAll,
              child: Container(
                decoration: AppDecorations.card,
                padding: AppDimensions.paddingCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${semester.academicYear} • Semester ${semester.semesterNumber}',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.xs),
                    const Text(
                      'Semester GPA',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: AppDimensions.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          currentGpa.toStringAsFixed(2),
                          style: AppTextStyles.displaySmall,
                        ),
                        const Text(
                          ' / 4.0',
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.md),

                    Row(
                      children: [
                        Expanded(
                          child: _infoCard('Credits', totalCredits.toStringAsFixed(1)),
                        ),
                        const SizedBox(width: AppDimensions.md),
                        Expanded(
                          child: _infoCard('Subjects', subjects.length.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Subheader Section
          SliverToBoxAdapter(
            child: Padding(
              padding: AppDimensions.paddingScreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subjects',
                    style: AppTextStyles.headlineSmall,
                  ),
                  Text(
                    subjects.isEmpty
                        ? '0 subjects'
                        : '${subjects.length} subject${subjects.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // List Section
          if (subjects.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimensions.huge),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: AppDimensions.iconXl,
                        color: AppColors.neutral,
                      ),
                      SizedBox(height: AppDimensions.md),
                      Text(
                        'No subjects added yet for this semester.\nTap "Add Subject" below to add a subject.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          color: AppColors.neutral,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _subjectCard(context, ref, subjects[index]),
                childCount: subjects.length,
              ),
            ),

          // Bottom padding so content is not hidden by the FAB
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: AppDimensions.paddingHorizontalLg,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddSubject(initialSemesterId: semester.id),
              ),
            );
          },
          foregroundColor: AppColors.onPrimary,
          backgroundColor: AppColors.primary,
          label: const Text('Add Subject'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Helper for info boxes
  Widget _infoCard(String title, String value) {
    return Container(
      padding: AppDimensions.paddingAllSm,
      decoration: AppDecorations.statTile,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.titleMedium,
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(WidgetRef ref, String grade) {
    final activeGrades = ref.watch(activeGradeDefinitionsProvider);
    final match = activeGrades.where(
      (g) => g.grade.trim().toUpperCase() == grade.trim().toUpperCase(),
    );
    if (match.isNotEmpty) {
      return Color(match.first.colorValue);
    }
    final fallbackMatch = gradeDefinitions.where(
      (g) => g.grade.trim().toUpperCase() == grade.trim().toUpperCase(),
    );
    if (fallbackMatch.isNotEmpty) {
      return Color(fallbackMatch.first.colorValue);
    }
    return AppColors.success;
  }

  // Subject item widget
  Widget _subjectCard(BuildContext context, WidgetRef ref, SemesterSubjectEntity attempt) {
    final gradeName = attempt.grade ?? '?';
    final gradeColor = _getGradeColor(ref, gradeName);
    final subjectName = attempt.subject?.subjectName ?? 'Unnamed Subject';

    return Padding(
      padding: AppDimensions.paddingScreen,
      child: Container(
        decoration: AppDecorations.card,
        padding: AppDimensions.paddingCard,
        child: Row(
          children: [
            Container(
              height: AppDimensions.gradeBadgeLarge,
              width: AppDimensions.gradeBadgeLarge,
              alignment: Alignment.center,
              decoration: AppDecorations.gradeBadgeRounded(gradeColor),
              child: Text(
                gradeName,
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: AppTextStyles.titleMedium,
                  ),
                  Text(
                    '${attempt.credits.toStringAsFixed(0)} Credits',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.edit_outlined),
              color: AppColors.textSecondary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddSubject(
                      initialSemesterId: semester.id,
                      attemptToEdit: attempt,
                    ),
                  ),
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.textSecondary,
              onPressed: () async {
                await deleteSubjectAttempt(ref, attempt);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteSemesterDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusMd,
          ),
          title: const Text(
            'Delete Semester?',
            style: AppTextStyles.headlineSmall,
          ),
          content: Text(
            'Are you sure you want to delete "${semester.name}"? This will permanently remove this semester and all its subject entries.',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.onError,
                minimumSize: const Size(80, 36),
              ),
              onPressed: () async {
                await deleteSemester(ref, semester.id);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semester deleted successfully')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
