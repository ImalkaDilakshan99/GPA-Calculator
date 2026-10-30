import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/view/pages/add_subject.dart';

class Semester extends StatefulWidget {
  const Semester({super.key});

  @override
  State<Semester> createState() => _SemesterState();
}

class _SemesterState extends State<Semester> {
  @override
  Widget build(BuildContext context) {
    const String appTitle = "Semester";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Center(
              child: Text(
                appTitle,
                style: AppTextStyles.headlineMedium,
              ),
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
                    const Text(
                      'Semester GPA',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '3.90',
                          style: AppTextStyles.displaySmall,
                        ),
                        Text(
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
                        Expanded(child: infoCard('Credits', '18')),
                        const SizedBox(width: AppDimensions.md),
                        Expanded(child: infoCard('Subjects', '5')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Subheader Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: AppDimensions.paddingScreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subjects',
                    style: AppTextStyles.headlineSmall,
                  ),
                  Text(
                    'Sort by Grade',
                    style: TextStyle(
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
          SliverList(
            delegate: SliverChildListDelegate([
              subject('Data Structures', 'CS 101', '3', 'A'),
              subject('Algorithms', 'CS 102', '3', 'A-'),
              subject('Database Systems', 'CS 201', '4', 'B+'),
            ]),
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
                builder: (context) => const AddSubject(),
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

  // Refactored subject widget with parameters
  Widget subject(String name, String code, String credits, String grade) {
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
              decoration: AppDecorations.gradeBadgeRounded(AppColors.success),
              child: Text(
                grade,
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.titleMedium,
                ),
                Row(
                  children: [
                    Text(
                      code,
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    Text(
                      '$credits Credits',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            IconButton(
              icon: const Icon(Icons.edit),
              color: AppColors.secondary,
              onPressed: () {
                // Edit subject action
              },
            ),
          ],
        ),
      ),
    );
  }
}
