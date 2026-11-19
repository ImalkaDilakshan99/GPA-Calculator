import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/view/pages/components/gpa_circular_progressbar.dart';
import 'package:gpa_calculator/view/pages/semester_add.dart';
import 'package:gpa_calculator/view/pages/semester_view.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semestersAsync = ref.watch(semestersStreamProvider);
    final cumulativeResult = ref.watch(cumulativeGpaProvider);
    final cumulativeGPA = cumulativeResult.gpa;
    final totalCredits = cumulativeResult.totalCredits;
    final totalGradePoints = cumulativeResult.qualityPoints;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: false,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Padding(
              padding: AppDimensions.paddingAllSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: AppTextStyles.headlineLarge,
                  ),
                  Text(
                    'Welcome back, User!',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Center(child: GPACircularProgressBar(gpa: cumulativeGPA)),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppDimensions.xxl),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: AppDimensions.paddingHorizontalLg,
              child: Row(
                children: [
                  Expanded(child: _statTile('Total Credits', totalCredits)),
                  const SizedBox(width: AppDimensions.lg),
                  Expanded(child: _statTile('Grade Points', totalGradePoints)),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppDimensions.xxl),
          ),

          // Semester History header
          SliverToBoxAdapter(
            child: semestersAsync.when(
              data: (semesters) => Padding(
                padding: AppDimensions.paddingHorizontalLg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Semester History',
                      style: AppTextStyles.headlineMedium,
                    ),
                    const SizedBox(width: AppDimensions.lg),
                    Text(
                      semesters.isEmpty
                          ? ''
                          : '${semesters.length} semester${semesters.length == 1 ? '' : 's'}',
                      style: const TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Padding(
                padding: AppDimensions.paddingHorizontalLg,
                child: Text('Semester History', style: AppTextStyles.headlineMedium),
              ),
              error: (err, stack) => const SizedBox.shrink(),
            ),
          ),

          // Semester list
          semestersAsync.when(
            data: (semesters) {
              if (semesters.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppDimensions.huge),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: AppDimensions.iconXl,
                            color: AppColors.neutral,
                          ),
                          SizedBox(height: AppDimensions.md),
                          Text(
                            'No semesters yet.\nTap + to add your first semester.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 14,
                              color: AppColors.neutral,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _semesterCard(context, ref, semesters[index]),
                  childCount: semesters.length,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(child: Padding(
                padding: EdgeInsets.all(AppDimensions.huge),
                child: CircularProgressIndicator(),
              )),
            ),
            error: (err, _) => SliverToBoxAdapter(
              child: Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SemesterAdd()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _statTile(String title, double value) {
    return Container(
      decoration: AppDecorations.statTile,
      padding: AppDimensions.paddingAllSm,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: AppTextStyles.headlineLarge,
          ),
        ],
      ),
    );
  }

  Widget _semesterCard(BuildContext context, WidgetRef ref, SemesterEntity semester) {
    // Calculate this semester's GPA from its subjects
    final gpaResult = ref.watch(semesterGpaProvider(semester.subjects));
    final semesterGpa = gpaResult.gpa;

    return Padding(
      padding: AppDimensions.paddingScreen,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: AppDecorations.card,
          child: InkWell(
            borderRadius: AppDimensions.borderRadiusMd,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SemesterView(semester: semester),
                ),
              );
            },
            child: Padding(
              padding: AppDimensions.paddingCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        semester.name,
                        style: AppTextStyles.headlineLarge,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: AppDimensions.iconSm,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),

                  Text(
                    '${semester.academicYear} • Semester ${semester.semesterNumber}',
                    style: AppTextStyles.bodyMedium,
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          const Text(
                            'Term GPA',
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            semesterGpa.toStringAsFixed(2),
                            style: AppTextStyles.displaySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
