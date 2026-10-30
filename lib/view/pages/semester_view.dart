import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/models/course_model.dart';
import 'package:gpa_calculator/models/semester_model.dart';
import 'package:gpa_calculator/view/pages/add_subject.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class SemesterView extends ConsumerStatefulWidget {
  final SemesterModel semester;

  const SemesterView({super.key, required this.semester});

  @override
  ConsumerState<SemesterView> createState() => _SemesterViewState();
}

// Backwards compatibility alias
typedef Semester = SemesterView;

class _SemesterViewState extends ConsumerState<SemesterView> {
  @override
  Widget build(BuildContext context) {
    // Watch courses to reactively update the subject list, credit count, and GPA
    final courses = ref.watch(gpaProvider);
    final totalCredits = courses.fold<double>(0.0, (sum, c) => sum + c.credits);
    final currentGpa = courses.isNotEmpty
        ? ref.watch(gpaProvider.notifier).calculateGPA()
        : widget.semester.gpa;

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
              widget.semester.name,
              style: AppTextStyles.headlineMedium,
            ),
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
                    if (widget.semester.year.isNotEmpty) ...[
                      Text(
                        widget.semester.year,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: AppDimensions.xs),
                    ],
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
                          child: infoCard('Credits', totalCredits.toStringAsFixed(1)),
                        ),
                        const SizedBox(width: AppDimensions.md),
                        Expanded(
                          child: infoCard('Subjects', courses.length.toString()),
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
                    courses.isEmpty
                        ? '0 subjects'
                        : '${courses.length} subject${courses.length == 1 ? '' : 's'}',
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
          if (courses.isEmpty)
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
                (context, index) => subject(courses[index]),
                childCount: courses.length,
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
                builder: (context) => AddSubject(initialSemester: widget.semester),
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
  Widget infoCard(String title, String value) {
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

  Color _getGradeColor(String grade) {
    final match = gradeDefinitions.where(
      (g) => g.grade.trim().toUpperCase() == grade.trim().toUpperCase(),
    );
    if (match.isNotEmpty) {
      return Color(match.first.colorValue);
    }
    return AppColors.success;
  }

  // Subject item widget
  Widget subject(Course course) {
    final gradeColor = _getGradeColor(course.grade);
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
                course.grade,
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
                    course.name.isEmpty ? 'Unnamed Subject' : course.name,
                    style: AppTextStyles.titleMedium,
                  ),
                  Text(
                    '${course.credits.toStringAsFixed(0)} Credits',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.textSecondary,
              onPressed: () {
                ref.read(gpaProvider.notifier).removeCourse(course.id);
                // Also update the semester's GPA after deletion
                final updatedGpa = ref.read(gpaProvider.notifier).calculateGPA();
                ref.read(semesterProvider.notifier).updateSemester(
                  widget.semester.id,
                  gpa: updatedGpa,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
