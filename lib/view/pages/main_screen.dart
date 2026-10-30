import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/view/pages/components/app_menu_bar.dart';
import 'package:gpa_calculator/view/pages/dashboard.dart';
import 'package:gpa_calculator/view/pages/profile_view.dart';
import 'package:gpa_calculator/view/pages/settings_view.dart';

/// Root navigation shell housing the Dashboard, Profile, and Settings screens
/// with the centralized floating menu bar.
class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    Dashboard(),
    ProfileView(),
    SettingsView(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppMenuBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

