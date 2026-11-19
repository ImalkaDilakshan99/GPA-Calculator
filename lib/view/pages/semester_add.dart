import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  int _semesterNumber = 1;
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
                  if (int.tryParse(value.trim()) == null) {
                    return 'Please enter a valid year (e.g. 2024)';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Academic Year',
                  hintText: 'e.g. 2024',
                ),
              ),

              const SizedBox(height: AppDimensions.lg),

              // Semester number selector
              Container(
                decoration: AppDecorations.counterBox,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: AppDimensions.xs,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: AppDimensions.iconXl,
                      icon: const Icon(Icons.remove),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_semesterNumber > 1) _semesterNumber--;
                        });
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          _semesterNumber.toString(),
                          style: AppTextStyles.displayLarge,
                        ),
                        const Text(
                          'Semester Number',
                          style: AppTextStyles.labelMedium,
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: AppDimensions.iconXl,
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_semesterNumber < 12) _semesterNumber++;
                        });
                      },
                    ),
                  ],
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
      final semester = SemesterEntity(
        id: 0, // auto-increment
        name: _nameController.text.trim(),
        academicYear: int.parse(_yearController.text.trim()),
        semesterNumber: _semesterNumber,
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
