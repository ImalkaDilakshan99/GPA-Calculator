import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class SemesterAdd extends ConsumerStatefulWidget {
  const SemesterAdd({super.key});

  @override
  ConsumerState<SemesterAdd> createState() => _SemesterAddState();
}

class _SemesterAddState extends ConsumerState<SemesterAdd> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  bool _isSaving = false;

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
                  hintText: 'e.g. Fall 2024 or Year 2 Sem 1',
                ),
              ),

              const SizedBox(height: AppDimensions.lg),

              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter academic year';
                  }
                  final year = int.tryParse(
                    RegExp(r'\d{4}').firstMatch(value)?.group(0) ?? value.trim(),
                  );
                  if (year == null) {
                    return 'Please enter a valid year (e.g. 2024)';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Academic Year',
                  hintText: 'e.g. 2024',
                ),
              ),

              const SizedBox(height: AppDimensions.xxl),

              ElevatedButton(
                onPressed: _isSaving ? null : _saveSemester,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onPrimary,
                        ),
                      )
                    : const Row(
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

  Future<void> _saveSemester() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final now = DateTime.now();
      final yearStr = _yearController.text.trim();
      final year = int.tryParse(
            RegExp(r'\d{4}').firstMatch(yearStr)?.group(0) ?? yearStr,
          ) ??
          now.year;

      // Automatically determine the next semester number for this academic year
      final existingSemesters =
          await ref.read(semesterRepositoryProvider).getAllSemesters();
      final semestersInYear =
          existingSemesters.where((s) => s.academicYear == year).toList();
      final nextSemesterNumber = semestersInYear.isEmpty
          ? 1
          : (semestersInYear
                  .map((s) => s.semesterNumber)
                  .reduce((a, b) => a > b ? a : b) +
              1);

      final semester = SemesterEntity(
        id: 0, // auto-increment
        name: _nameController.text.trim(),
        academicYear: year,
        semesterNumber: nextSemesterNumber,
        createdAt: now,
        updatedAt: now,
      );

      await createSemester(ref, semester);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semester added successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving semester: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
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
