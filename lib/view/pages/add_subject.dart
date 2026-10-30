import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/models/grade_model.dart';
import 'package:gpa_calculator/models/semester_model.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

class AddSubject extends ConsumerStatefulWidget {
  const AddSubject({super.key});

  @override
  ConsumerState<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends ConsumerState<AddSubject> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  int credits = 0;
  static const int _maxCredits = 12;

  GradeModel? selectedGrade;
  SemesterModel? selectedSemester;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semesters = ref.watch(semesterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Subject")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: SingleChildScrollView(
        child: Column(
          children: [
            _heroBox(),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    //Fields for subject name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Subject Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a subject name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    //Fields for credits
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.remove),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                              const Text('Credits'),
                            ],
                          ),

                          IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.add),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
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

                    const SizedBox(height: 10),

                    //Fields for grade selection
                    const Row(
                      children: [
                        Text(
                          'Grade Obtained',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<GradeModel>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      hint: const Text('Select Grade'),
                      items: gradeDefinitions.map((grade) {
                        return DropdownMenuItem<GradeModel>(
                          value: grade,
                          child: Row(
                            children: [
                              // The Colored Circle
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Color(grade.colorValue),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    grade.grade,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(grade.gradePoint.toStringAsFixed(2)),
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
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Select the final grade awarded for this subject.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),

                    //Change the semester
                    const SizedBox(height: 10),

                    DropdownButtonFormField<SemesterModel>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      hint: const Text('Select Semester'),
                      items: semesters.map((semester) {
                        return DropdownMenuItem<SemesterModel>(
                          value: semester,
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, color: Colors.green),
                              const SizedBox(width: 10),
                              Text(semester.name),
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
                      onChanged: (SemesterModel? newValue) {
                        setState(() {
                          selectedSemester = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton.extended(
            onPressed: _saveSubject,
            label: const Text('Save Subject'),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }

  void _saveSubject() {
    if (!_formKey.currentState!.validate()) return;

    if (credits <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credits must be greater than 0')),
      );
      return;
    }

    // Add the course to the ViewModel
    final notifier = ref.read(gpaProvider.notifier);
    notifier.addCourse();
    final courses = ref.read(gpaProvider);
    final lastCourse = courses.last;
    notifier.updateCourse(
      lastCourse.id,
      name: _nameController.text.trim(),
      credits: credits.toDouble(),
      grade: selectedGrade!.grade,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subject added successfully')),
    );

    Navigator.of(context).pop();
  }

  Widget _heroBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, color: Colors.white),
            SizedBox(height: 8),
            Text(
              'NEW COURSE ENTRY',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
