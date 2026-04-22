import 'package:flutter/material.dart';
import 'package:gpa_calculator/models/grade_model.dart';

class Addsubject extends StatefulWidget {
  const Addsubject({super.key});

  @override
  State<Addsubject> createState() => _AddsubjectState();
}

class _AddsubjectState extends State<Addsubject> {
  final _formKey = GlobalKey<FormState>();

  int credits = 0;

  List<GradeModel> grades = [
    GradeModel(grade: 'A', color: Colors.green, gradepoint: 4.0),
    GradeModel(grade: 'B', color: Colors.blue, gradepoint: 3.0),
    GradeModel(grade: 'C', color: Colors.orange, gradepoint: 2.0),
    GradeModel(grade: 'D', color: Colors.red, gradepoint: 1.0),
    GradeModel(grade: 'F', color: Colors.black, gradepoint: 0.0),
  ];

  GradeModel? selectedGrade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Subject")),

      body: Column(
        children: [
          _HeroBox(),

          SizedBox(height: 10),

          Form(
            key: _formKey,

            child: Column(
              children: [
                //Fields for subject name
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Subject Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                //Fields for credits
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.remove),
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
                      ),

                      Column(
                        children: [
                          Text(
                            credits.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                          Text('Credits'),
                        ],
                      ),

                      IconButton(
                        iconSize: 50,
                        icon: Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            credits++;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                //Fields for grade selection
                DropdownButton<GradeModel>(
                  value: selectedGrade,
                  items: grades.map((grade) {
                    return DropdownMenuItem<GradeModel>(
                      value: grade,
                      child: Row(
                        children: [
                          // The Colored Circle
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: grade.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(grade.grade),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (GradeModel? newValue) {
                    setState(() {
                      selectedGrade = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _HeroBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, color: Colors.white),
            const SizedBox(height: 8),
            const Text(
              'NEW COURSE ENTRY',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
