import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/models/semester_model.dart';
import 'package:gpa_calculator/view/pages/components/gpa_circular_progressbar.dart';
import 'package:gpa_calculator/view/pages/semester_add.dart';
import 'package:gpa_calculator/view/pages/semester_view.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesters = ref.watch(semesterProvider);
    final notifier = ref.read(semesterProvider.notifier);
    final cumulativeGPA = notifier.calculateCumulativeGPA();

    // Calculate totals from all semesters
    const totalCredits = 0.0; // TODO: aggregate when courses are persisted per semester
    const totalGradePoints = 0.0;

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

          SliverToBoxAdapter(
            child: Padding(
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
          ),

          if (semesters.isEmpty)
            const SliverToBoxAdapter(
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
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _semesterCard(context, semesters[index]),
                childCount: semesters.length,
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

  Widget _semesterCard(BuildContext context, SemesterModel semester) {
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
                    semester.year,
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
                            semester.gpa.toStringAsFixed(2),
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
