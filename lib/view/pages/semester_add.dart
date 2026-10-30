import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/models/semester_model.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

enum SemesterNumber { sem1, sem2 }

class SemesterAdd extends ConsumerStatefulWidget {
  const SemesterAdd({super.key});

  @override
  ConsumerState<SemesterAdd> createState() => _SemesterAddState();
}

class _SemesterAddState extends ConsumerState<SemesterAdd> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  SemesterNumber? _selectedSemester;

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Semester',
          style: AppTextStyles.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppDimensions.paddingScreenAll,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _heroCard(),

              const SizedBox(height: AppDimensions.xxl),

              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter semester name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Semester Name',
                  hintText: 'e.g. Fall 2024 or sem1 in yr2',
                ),
              ),

              const SizedBox(height: AppDimensions.lg),

              TextFormField(
                controller: _yearController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter academic year';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Academic Year',
                  hintText: 'e.g. 2024/2025',
                ),
              ),

              const SizedBox(height: AppDimensions.xxl),

              ElevatedButton(
                onPressed: _saveSemester,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined),
                    SizedBox(width: AppDimensions.sm),
                    Text('Save Semester'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSemester() {
    if (!_formKey.currentState!.validate()) return;

    final semester = SemesterModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      year: _yearController.text.trim(),
    );

    ref.read(semesterProvider.notifier).addSemester(semester);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semester added successfully')),
    );

    Navigator.of(context).pop();
  }

  Widget _heroCard() {
    return Column(
      children: [
        Container(
          width: AppDimensions.heroCircleSize,
          height: AppDimensions.heroCircleSize,
          decoration: AppDecorations.heroCircle,
          child: const Icon(
            Icons.date_range_outlined,
            color: AppColors.onPrimary,
            size: AppDimensions.iconHero,
          ),
        ),
        const SizedBox(height: AppDimensions.lg),
        const Text(
          'New Semester Entry',
          style: AppTextStyles.headlineSmall,
        ),
      ],
    );
  }
}
