import 'package:flutter/material.dart';
import 'add_snapshot_page.dart';
import 'view_snapshots_page.dart';
// import 'add_course_page.dart';
// import 'manage_courses_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduSnap Organizer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Manage your course images & notes',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddSnapshotPage()),
                  );
                },
                child: const Text('Add Snapshot', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewSnapshotsPage()),
                  );
                },
                child: const Text('View Snapshots', style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  // will be activated when your friend adds the pages
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Course screens coming soon.")),
                  );
                },
                child: const Text("Add Course", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  // will be activated later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Course screens coming soon.")),
                  );
                },
                child: const Text("Edit Courses", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

