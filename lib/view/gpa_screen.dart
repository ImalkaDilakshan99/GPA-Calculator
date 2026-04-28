import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class GPAScreen extends ConsumerWidget {
  const GPAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(gpaProvider);
    final gpa = ref.read(gpaProvider.notifier).calculateGPA();

    return Scaffold(
      appBar: AppBar(title: Text("GPA Calculator - ${gpa.toStringAsFixed(2)}")),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseInputRow(course: courses[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(gpaProvider.notifier).addCourse(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class CourseInputRow extends StatelessWidget {
  final dynamic course;

  const CourseInputRow({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(course.toString()));
  }
}
