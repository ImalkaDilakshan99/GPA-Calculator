import 'package:flutter/material.dart';

class Semester extends StatefulWidget {
  const Semester({super.key});

  @override
  State<Semester> createState() => _SemesterState();
}

class _SemesterState extends State<Semester> {
  @override
  Widget build(BuildContext context) {
    const String appTitle = "Semester";

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: const Text(
                appTitle,
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Header Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Semester GPA',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '3.90',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(' / 4.0', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                  
                      const SizedBox(height: 10),
                  
                      Row(
                        children: [
                          Expanded(child: infoCard('Credits', '18')),
                          const SizedBox(width: 10),
                          Expanded(child: infoCard('Subjects', '5')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Subheader Section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subjects',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Sort by Grade', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),

          // List Section
          SliverList(
            delegate: SliverChildListDelegate([
              subject('Data Structures', 'CS 101', '3', 'A'),
              subject('Algorithms', 'CS 102', '3', 'A-'),
              subject('Database Systems', 'CS 201', '4', 'B+'),
            ]),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FloatingActionButton.extended(
         
          onPressed: () {
            // Add subject action
          },
        
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: const Text('Add Subject'),
          icon: const Icon(Icons.add),
          
        ),
      ),
    );
  }

  // Helper for info boxes
  Widget infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  // Refactored subject widget with parameters
  Widget subject(String name, String code, String credits, String grade) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  grade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(code, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 10),
                      Text(
                        '$credits Credits',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
        
              Spacer(),
        
              IconButton(icon: Icon(Icons.edit),
                color: Colors.green,
                onPressed: () {
                  // Edit action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
