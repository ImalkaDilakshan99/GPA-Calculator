import 'package:flutter/material.dart';
import 'package:gpa_calculator/view/pages/components/gpa_circular_progressbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.black,
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
          const SliverToBoxAdapter(
            child: Center(child: GPACircularProgressBar(gpa: 2.55)),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.blueGrey.shade50,
                      child: const Center(child: Text('Semester Overview Placeholder')),
                    ),
                  ],
                ),

                Container(
                  height: 200,
                  color: Colors.blueGrey.shade50,
                  child: const Center(child: Text('Semester Overview Placeholder')),
                ),
              ],
            ),
          ),

          
        ],
      ),
    );
  }
}
