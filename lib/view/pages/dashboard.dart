import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/view/pages/components/gpa_circular_progressbar.dart';
import 'package:gpa_calculator/view/pages/profile_view.dart';
import 'package:gpa_calculator/view/pages/semester_add.dart';
import 'package:gpa_calculator/view/pages/semester_view.dart';
import 'package:gpa_calculator/view/pages/settings_view.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semestersAsync = ref.watch(sortedSemestersProvider);
    final currentSort = ref.watch(semesterSortProvider);
    final cumulativeResult = ref.watch(cumulativeGpaProvider);
    final profileAsync = ref.watch(studentProfileStreamProvider);

    final cumulativeGPA = cumulativeResult.gpa;
    final totalCredits = cumulativeResult.totalCredits;
    final totalGradePoints = cumulativeResult.qualityPoints;

    final profileName = profileAsync.value?.name.trim();
    final firstName = (profileName != null && profileName.isNotEmpty)
        ? profileName.split(' ').first
        : 'Alex';

    return Scaffold(
      backgroundColor: const Color(0xFF0F111E),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Top Header Bar with Profile & Settings Navigation ─────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Welcome back, $firstName',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8E9BAE),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Profile navigation button
                        _headerIconButton(
                          icon: Icons.person_outline_rounded,
                          tooltip: 'Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileView(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        // Settings navigation button
                        _headerIconButton(
                          icon: Icons.settings_rounded,
                          tooltip: 'Settings',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsView(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),

            // ── Circular CGPA Display ─────────────────────────────────
            SliverToBoxAdapter(
              child: Center(
                child: GPACircularProgressBar(gpa: cumulativeGPA),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),

            // ── Total Credits & Grade Points Stat Cards ───────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _statTile(
                        title: 'Total Credits',
                        value: totalCredits % 1 == 0
                            ? totalCredits.toInt().toString()
                            : totalCredits.toStringAsFixed(1),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _statTile(
                        title: 'Grade Points',
                        value: totalGradePoints.toStringAsFixed(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 28),
            ),

            // ── Semester History Header ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Semester History',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PopupMenuButton<SemesterSortOption>(
                      initialValue: currentSort,
                      tooltip: 'Sort semesters',
                      color: const Color(0xFF1B1E30),
                      elevation: 8,
                      offset: const Offset(0, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Color(0xFF262B42), width: 1),
                      ),
                      onSelected: (option) {
                        ref.read(semesterSortProvider.notifier).setSortOption(option);
                      },
                      itemBuilder: (context) => [
                        _buildSortMenuItem(
                          option: SemesterSortOption.newestFirst,
                          currentSort: currentSort,
                          icon: Icons.calendar_today_outlined,
                        ),
                        _buildSortMenuItem(
                          option: SemesterSortOption.oldestFirst,
                          currentSort: currentSort,
                          icon: Icons.history_rounded,
                        ),
                        _buildSortMenuItem(
                          option: SemesterSortOption.gpaHighToLow,
                          currentSort: currentSort,
                          icon: Icons.trending_up_rounded,
                        ),
                        _buildSortMenuItem(
                          option: SemesterSortOption.gpaLowToHigh,
                          currentSort: currentSort,
                          icon: Icons.trending_down_rounded,
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1E30),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF262B42), width: 1),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.sort_rounded,
                              size: 16,
                              color: Color(0xFF3861FB),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Sort by',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3861FB),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 18,
                              color: Color(0xFF3861FB),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 14),
            ),

            // ── Semester List ─────────────────────────────────────────
            semestersAsync.when(
              data: (semesters) {
                if (semesters.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 48,
                              color: Color(0xFF6F7D95),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No semesters added yet.\nTap + to add your first semester.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF8E9BAE),
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
                    (context, index) =>
                        _semesterCard(context, ref, semesters[index]),
                    childCount: semesters.length,
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(
                      color: Color(0xFF3861FB),
                    ),
                  ),
                ),
              ),
              error: (err, stack) => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error: $err',
                      style: const TextStyle(color: Colors.redAccent)),
                ),
              ),
            ),

            // Bottom padding for scroll clearance
            const SliverToBoxAdapter(
              child: SizedBox(height: 90),
            ),
          ],
        ),
      ),

      // ── Floating Action Button (Vibrant Squircle) ─────────────
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SemesterAdd()),
          );
        },
        backgroundColor: const Color(0xFF3861FB),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  /// Circular header action icon button (Profile & Settings)
  Widget _headerIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF1B1E30),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF262B42), width: 1),
        ),
        child: Icon(
          icon,
          size: 21,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Metric stat card (Credits and Grade Points)
  Widget _statTile({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF171A2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF22263C), width: 1),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: Color(0xFF8E9BAE),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Individual Semester Card matching reference screenshot
  Widget _semesterCard(
      BuildContext context, WidgetRef ref, SemesterEntity semester) {
    // Watch subjects and GPA for this semester reactively
    final subjectsAsync = ref.watch(semesterSubjectsStreamProvider(semester.id));
    final subjects = subjectsAsync.value ?? semester.subjects;
    final gpaResult = ref.watch(semesterGpaFromIdProvider(semester.id));
    final semesterGpa = gpaResult.gpa;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF171A2B),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF22263C), width: 1),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SemesterView(
                    semester: semester.copyWith(subjects: subjects),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blue left vertical accent pill indicator
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3861FB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title row: Semester Name & Chevron
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              semester.name,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 22,
                              color: Color(0xFF6F7D95),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Subtitle row: Year & Semester
                        Text(
                          'Year ${semester.academicYear}, Semester ${semester.semesterNumber}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Color(0xFF8E9BAE),
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Metrics row: Credits, Courses, Term GPA
                        Row(
                          children: [
                            // Credits
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Credits',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: Color(0xFF8E9BAE),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  gpaResult.totalCredits.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 28),
                            // Courses count
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Courses',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: Color(0xFF8E9BAE),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${subjects.length}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Term GPA
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Term GPA',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: Color(0xFF8E9BAE),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  semesterGpa.toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3861FB),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds an individual item in the sort popup menu.
  PopupMenuItem<SemesterSortOption> _buildSortMenuItem({
    required SemesterSortOption option,
    required SemesterSortOption currentSort,
    required IconData icon,
  }) {
    final isSelected = option == currentSort;
    return PopupMenuItem<SemesterSortOption>(
      value: option,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? const Color(0xFF3861FB) : const Color(0xFF8E9BAE),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              option.label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF3861FB) : Colors.white,
              ),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check_rounded,
              size: 18,
              color: Color(0xFF3861FB),
            ),
        ],
      ),
    );
  }
}
