import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(title: const Text('Add Semester')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              _heroCard(),

              const SizedBox(height: 24),

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
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
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
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<SemesterNumber>(
                initialValue: _selectedSemester,
                decoration: const InputDecoration(
                  labelText: 'Semester',
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                hint: const Text('Select Semester'),
                items: const [
                  DropdownMenuItem(
                    value: SemesterNumber.sem1,
                    child: Text('Semester 1'),
                  ),
                  DropdownMenuItem(
                    value: SemesterNumber.sem2,
                    child: Text('Semester 2'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Please select a semester';
                  }
                  return null;
                },
                onChanged: (SemesterNumber? value) {
                  setState(() {
                    _selectedSemester = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveSemester,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  iconSize: 24,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined),
                    SizedBox(width: 8),
                    Text('Save Semester', style: TextStyle(fontSize: 20)),
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
    return Column(children: [
      Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.date_range_outlined, color: Colors.white, size: 60)),
      const SizedBox(height: 16),
      const Text('New Semester Entry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
