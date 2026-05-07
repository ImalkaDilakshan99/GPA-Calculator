import 'package:flutter/material.dart';

enum SemesterNumber { sem1, sem2 }

class SemesterAdd extends StatefulWidget {
  const SemesterAdd({super.key});

  @override
  State<SemesterAdd> createState() => _SemesterAddState();
}

class _SemesterAddState extends State<SemesterAdd> {
  final _formKey = GlobalKey<FormState>();
  SemesterNumber? _selectedSemester;

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

              SizedBox(height: 24),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                value: _selectedSemester,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined,),
                    const SizedBox(width: 8),
                    const Text('Save Semester',style: TextStyle( fontSize: 20),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroCard() {
    return Column(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.date_range_outlined, color: Colors.white, size: 60,)),
      SizedBox(height: 16),
      Text('New Semester Entry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
