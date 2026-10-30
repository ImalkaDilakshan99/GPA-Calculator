import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/theme.dart';

/// Floating capsule menu bar hosting Dashboard, Profile, and Settings destinations.
/// Designed according to the application's centralized design system.
class AppMenuBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AppMenuBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.xl,
          vertical: AppDimensions.sm,
        ),
        child: Container(
          height: 64,
          decoration: AppDecorations.navBar,
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.dashboard_rounded,
                unselectedIcon: Icons.dashboard_outlined,
                label: 'Dashboard',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.person_rounded,
                unselectedIcon: Icons.person_outline_rounded,
                label: 'Profile',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.settings_rounded,
                unselectedIcon: Icons.settings_outlined,
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData unselectedIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onItemSelected(index),
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppDimensions.lg : AppDimensions.md,
          vertical: AppDimensions.sm,
        ),
        decoration: isSelected ? AppDecorations.navBarActiveItem : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? icon : unselectedIcon,
              size: AppDimensions.iconMd,
              color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
            ),
            if (isSelected) ...[
              const SizedBox(width: AppDimensions.xs),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

