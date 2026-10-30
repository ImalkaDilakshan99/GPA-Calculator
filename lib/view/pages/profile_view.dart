import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesters = ref.watch(semesterProvider);
    final cumulativeGpa = ref.watch(semesterProvider.notifier).calculateCumulativeGPA();
    final courses = ref.watch(gpaProvider);
    final totalCredits = courses.fold<double>(0.0, (sum, c) => sum + c.credits);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile', style: AppTextStyles.headlineMedium),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: AppDimensions.paddingScreenAll,
        child: Column(
          children: [
            // User Avatar & Name Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondary, width: 2),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 52,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                  const Text(
                    'Student User',
                    style: AppTextStyles.headlineLarge,
                  ),
                  const SizedBox(height: AppDimensions.xxs),
                  const Text(
                    'Bachelor of Science (Computer Science)',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.xxl),

            // Academic Metrics Row
            Row(
              children: [
                Expanded(
                  child: _metricTile(
                    label: 'Cumulative GPA',
                    value: cumulativeGpa.toStringAsFixed(2),
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Expanded(
                  child: _metricTile(
                    label: 'Semesters',
                    value: semesters.length.toString(),
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Expanded(
                  child: _metricTile(
                    label: 'Credits',
                    value: totalCredits.toStringAsFixed(0),
                    color: AppColors.success,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.xxl),

            // Academic Information Section
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Academic Details', style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppDimensions.md),
                  _infoRow(Icons.school_outlined, 'Degree', 'Undergraduate'),
                  const Divider(color: AppColors.borderSubtle, height: AppDimensions.lg),
                  _infoRow(Icons.domain_outlined, 'Department', 'Faculty of Computing'),
                  const Divider(color: AppColors.borderSubtle, height: AppDimensions.lg),
                  _infoRow(Icons.calendar_today_outlined, 'Academic Year', '2024 / 2025'),
                  const Divider(color: AppColors.borderSubtle, height: AppDimensions.lg),
                  _infoRow(Icons.star_outline_rounded, 'Target CGPA', '3.80 / 4.00'),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.xl),

            // Profile Actions
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                children: [
                  _actionTile(
                    icon: Icons.badge_outlined,
                    title: 'Student ID & Details',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Student profile details')),
                      );
                    },
                  ),
                  const Divider(color: AppColors.borderSubtle, height: AppDimensions.lg),
                  _actionTile(
                    icon: Icons.file_download_outlined,
                    title: 'Export Academic Record',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Academic record exported')),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _metricTile({required String label, required String value, required Color color}) {
    return Container(
      decoration: AppDecorations.statTile,
      padding: AppDimensions.paddingAllSm,
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.xxs),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: AppDimensions.iconSm, color: AppColors.secondary),
        const SizedBox(width: AppDimensions.md),
        Text(label, style: AppTextStyles.bodyMedium),
        const Spacer(),
        Text(value, style: AppTextStyles.titleSmall),
      ],
    );
  }

  Widget _actionTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.borderRadiusSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
        child: Row(
          children: [
            Icon(icon, size: AppDimensions.iconMd, color: AppColors.primaryLight),
            const SizedBox(width: AppDimensions.md),
            Text(title, style: AppTextStyles.bodyLarge),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: AppDimensions.iconXs, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

