import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings', style: AppTextStyles.headlineMedium),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: AppDimensions.paddingScreenAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Grading Scale
            const Text('Grading System', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppDimensions.sm),
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.grade_outlined,
                    title: 'Grading Scale',
                    subtitle: 'Standard 4.0 Scale (A+ to F)',
                    trailing: const Text(
                      '4.00 Max',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _showGradingScaleDialog(context),
                  ),
                  const Divider(
                    color: AppColors.borderSubtle,
                    height: AppDimensions.lg,
                  ),
                  _settingTile(
                    icon: Icons.calculate_outlined,
                    title: 'GPA Calculation Mode',
                    subtitle: 'Weighted by Course Credit Hours',
                    trailing: const Text(
                      'Active',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.xxl),

            // Section 2: Appearance & Theme
            const Text('Appearance', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppDimensions.sm),
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Theme',
                    subtitle: 'Dark Mode (Centralized Design System)',
                    trailing: const Text(
                      'Dark',
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.borderSubtle,
                    height: AppDimensions.lg,
                  ),
                  _settingTile(
                    icon: Icons.palette_outlined,
                    title: 'Accent Palette',
                    subtitle: 'Primary #2B2BEE • Secondary #A5A5FF',
                    trailing: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.xxl),

            // Section 3: Data Management
            const Text('Data Management', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppDimensions.sm),
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.restart_alt_outlined,
                    title: 'Reset Semester Data',
                    subtitle: 'Clear all semesters and subject entries',
                    titleColor: AppColors.error,
                    onTap: () => _confirmResetDialog(context, ref),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.xxl),

            // Section 4: About
            const Text('About', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppDimensions.sm),
            Container(
              decoration: AppDecorations.card,
              padding: AppDimensions.paddingCard,
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.info_outline,
                    title: 'App Version',
                    subtitle: 'GPA Calculator v0.1.0',
                  ),
                  const Divider(
                    color: AppColors.borderSubtle,
                    height: AppDimensions.lg,
                  ),
                  _settingTile(
                    icon: Icons.architecture,
                    title: 'Architecture',
                    subtitle: 'MVVM with Riverpod & Centralized Theme',
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

  Widget _settingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDimensions.borderRadiusSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDimensions.iconMd,
              color: titleColor ?? AppColors.secondary,
            ),
            const SizedBox(width: AppDimensions.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.bodySmall),
                  ],
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  void _showGradingScaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusMd,
          ),
          title: const Text(
            'Grading Scale',
            style: AppTextStyles.headlineSmall,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: gradeDefinitions.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: AppColors.borderSubtle, height: 8),
              itemBuilder: (context, index) {
                final grade = gradeDefinitions[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: AppDecorations.gradeBadge(
                        Color(grade.colorValue),
                      ),
                      child: Center(
                        child: Text(
                          grade.grade,
                          style: const TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${grade.gradePoint.toStringAsFixed(2)} Points',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(color: AppColors.secondary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusMd,
          ),
          title: const Text(
            'Reset All Data?',
            style: AppTextStyles.headlineSmall,
          ),
          content: const Text(
            'This will permanently delete all added semesters and subject entries.',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
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
              onPressed: () {
                // Clear all semesters
                final semesters = ref.read(semesterProvider);
                for (final s in semesters) {
                  ref.read(semesterProvider.notifier).removeSemester(s.id);
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data has been reset')),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
