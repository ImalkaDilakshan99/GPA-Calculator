import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/models/course_model.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class GPAScreen extends ConsumerWidget {
  const GPAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(gpaProvider);
    final gpa = ref.watch(gpaProvider.notifier).calculateGPA();

    return Scaffold(
      appBar: AppBar(
        title: Text("GPA Calculator — ${gpa.toStringAsFixed(2)}"),
      ),
      body: courses.isEmpty
          ? const Center(
              child: Text(
                'Tap + to add a course',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: AppDimensions.paddingScreen,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseInputRow(course: courses[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(gpaProvider.notifier).addCourse(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseInputRow extends StatelessWidget {
  final Course course;

  const CourseInputRow({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.sm),
      child: ListTile(
        title: Text(
          course.name.isEmpty ? 'Unnamed Course' : course.name,
          style: AppTextStyles.titleMedium,
        ),
        subtitle: Text(
          '${course.credits} credits • Grade: ${course.grade}',
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }
}
