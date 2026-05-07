import 'package:flutter/material.dart';
import 'package:gpa_calculator/view/pages/components/gpa_circular_progressbar.dart';
import 'package:gpa_calculator/view/pages/semester_add.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111127),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: false,
            backgroundColor: Color(0xFF0f0f20),
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome back, User!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(child: GPACircularProgressBar(gpa: 2.55)),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(child: _StatTile('Total Credits', 120)),
                SizedBox(width: 16),
                Expanded(child: _StatTile('Grade Points', 412.5)),
              ],
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Semester History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'View All',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
              ],
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _semesterCard(),
              childCount: 5,
            ),
          ),
        ],
      ),

      floatingActionButton: //Semester Add Button
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SemesterAdd()),
          );
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _StatTile(String title, double value) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 38, 38, 70),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _semesterCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1a1a2e),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Fall 2023',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                ],
              ),

              Text(
                'Year 3, Semester 1',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 25),

              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Credits',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '18.0',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 25),

                  Column(
                    children: [
                      Text(
                        'Courses',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '6',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  Column(
                    children: [
                      Text(
                        'Term GPA',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '3.90',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
