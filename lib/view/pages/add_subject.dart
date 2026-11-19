import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/models/grade_model.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

class AddSubject extends ConsumerStatefulWidget {
  final int? initialSemesterId;

  const AddSubject({super.key, this.initialSemesterId});

  @override
  ConsumerState<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends ConsumerState<AddSubject> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  int credits = 0;
  static const int _maxCredits = 12;

  GradeModel? selectedGrade;
  SemesterEntity? selectedSemester;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semestersAsync = ref.watch(semestersStreamProvider);

    // Pre-select semester when semesters load and we have an initial ID
    semestersAsync.whenData((semesters) {
      if (selectedSemester == null && widget.initialSemesterId != null) {
        final match = semesters.where((s) => s.id == widget.initialSemesterId);
        if (match.isNotEmpty) {
          // Use addPostFrameCallback to avoid setState during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && selectedSemester == null) {
              setState(() => selectedSemester = match.first);
            }
          });
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Subject",
          style: AppTextStyles.headlineSmall,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: SingleChildScrollView(
        child: Column(
          children: [
            _heroBox(),

            const SizedBox(height: AppDimensions.md),

            Padding(
              padding: AppDimensions.paddingHorizontalLg,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Fields for subject name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Subject Name",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a subject name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppDimensions.md),

                    // Fields for credits
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
                                if (credits > 0) {
                                  credits--;
                                }
                              });
                            },
                          ),

                          Column(
                            children: [
                              Text(
                                credits.toString(),
                                style: AppTextStyles.displayLarge,
                              ),
                              const Text(
                                'Credits',
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
                                if (credits < _maxCredits) {
                                  credits++;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimensions.lg),

                    // Fields for grade selection
                    const Row(
                      children: [
                        Text(
                          'Grade Obtained',
                          style: AppTextStyles.titleMedium,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.sm),

                    DropdownButtonFormField<GradeModel>(
                      dropdownColor: AppColors.surfaceVariant,
                      hint: const Text('Select Grade'),
                      items: gradeDefinitions.map((grade) {
                        return DropdownMenuItem<GradeModel>(
                          value: grade,
                          child: Row(
                            children: [
                              // The Colored Circle
                              Container(
                                width: AppDimensions.gradeBadgeSize,
                                height: AppDimensions.gradeBadgeSize,
                                decoration: AppDecorations.gradeBadge(
                                  Color(grade.colorValue),
                                ),
                                child: Center(
                                  child: Text(
                                    grade.grade,
                                    style: const TextStyle(
                                      color: AppColors.textWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimensions.md),
                              Text(
                                grade.gradePoint.toStringAsFixed(2),
                                style: AppTextStyles.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a grade';
                        }
                        return null;
                      },
                      onChanged: (GradeModel? newValue) {
                        setState(() {
                          selectedGrade = newValue;
                        });
                      },
                    ),

                    const SizedBox(height: AppDimensions.xs),

                    const Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Select the final grade awarded for this subject.',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),

                    // Select the semester
                    const SizedBox(height: AppDimensions.lg),

                    semestersAsync.when(
                      data: (semesters) {
                        return DropdownButtonFormField<SemesterEntity>(
                          key: ValueKey(selectedSemester?.id),
                          initialValue: selectedSemester,
                          dropdownColor: AppColors.surfaceVariant,
                          hint: const Text('Select Semester'),
                          items: semesters.map((semester) {
                            return DropdownMenuItem<SemesterEntity>(
                              value: semester,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: AppColors.secondary,
                                    size: AppDimensions.iconSm,
                                  ),
                                  const SizedBox(width: AppDimensions.md),
                                  Text(
                                    '${semester.name} (${semester.academicYear})',
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a semester';
                            }
                            return null;
                          },
                          onChanged: (SemesterEntity? newValue) {
                            setState(() {
                              selectedSemester = newValue;
                            });
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Text('Error loading semesters: $err'),
                    ),

                    const SizedBox(height: AppDimensions.xxxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: AppDimensions.paddingHorizontalLg,
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: _isSaving ? null : _saveSubject,
            label: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.onPrimary,
                    ),
                  )
                : const Text(
                    'Save Subject',
                    style: AppTextStyles.buttonSmall,
                  ),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            icon: _isSaving ? null : const Icon(Icons.check),
          ),
        ),
      ),
    );
  }

  Future<void> _saveSubject() async {
    if (!_formKey.currentState!.validate()) return;

    if (credits <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credits must be greater than 0')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await addSubjectToSemester(
        ref,
        subjectName: _nameController.text.trim(),
        semesterId: selectedSemester!.id,
        credits: credits.toDouble(),
        grade: selectedGrade!.grade,
        gradePoint: selectedGrade!.gradePoint,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Subject added successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving subject: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _heroBox() {
    return Padding(
      padding: AppDimensions.paddingHorizontalLg,
      child: Container(
        height: AppDimensions.heroCardHeight,
        width: double.infinity,
        decoration: AppDecorations.heroCard,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              color: AppColors.onPrimary,
              size: AppDimensions.iconLg,
            ),
            SizedBox(height: AppDimensions.sm),
            Text(
              'NEW COURSE ENTRY',
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamily,
                color: AppColors.onPrimary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
