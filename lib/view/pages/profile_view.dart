import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semestersAsync = ref.watch(semestersStreamProvider);
    final cumulativeResult = ref.watch(cumulativeGpaProvider);
    final cumulativeGpa = cumulativeResult.gpa;
    final totalCredits = cumulativeResult.totalCredits;

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
            // User Avatar & Name Header (matches reference design)
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 124,
                    height: 124,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Avatar with glowing neon ring
                        Container(
                          width: 114,
                          height: 114,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF6B42FF),
                              width: 3.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x666B42FF),
                                blurRadius: 24,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile_avatar.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.surfaceVariant,
                                  child: const Icon(
                                    Icons.person_rounded,
                                    size: 56,
                                    color: AppColors.onPrimary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Edit Button Badge at bottom-right
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E2E),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2E2E42),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.lg),

                  // Name
                  const Text(
                    'Alex Rivera',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                      letterSpacing: -0.2,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.xxs),

                  // Major
                  const Text(
                    'Computer Science Major',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E64FF),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.xs),

                  // University & Class
                  const Text(
                    'Stanford University • Class of 2025',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 13,
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
                  child: semestersAsync.when(
                    data: (semesters) => _metricTile(
                      label: 'Semesters',
                      value: semesters.length.toString(),
                      color: AppColors.secondary,
                    ),
                    loading: () => _metricTile(
                      label: 'Semesters',
                      value: '...',
                      color: AppColors.secondary,
                    ),
                    error: (err, stack) => _metricTile(
                      label: 'Semesters',
                      value: '0',
                      color: AppColors.secondary,
                    ),
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
