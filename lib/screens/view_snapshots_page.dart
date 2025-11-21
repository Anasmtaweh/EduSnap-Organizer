import 'dart:io';
import 'package:flutter/material.dart';

import '../snapshot_store.dart';
import '../course_store.dart';

import '../models/course.dart';
import '../utils/file_utils.dart';
import 'snapshot_details_page.dart';

class ViewSnapshotsPage extends StatefulWidget {
  const ViewSnapshotsPage({super.key});

  @override
  State<ViewSnapshotsPage> createState() => _ViewSnapshotsPageState();
}

class _ViewSnapshotsPageState extends State<ViewSnapshotsPage> {
  Course? _selectedFilter;

  void _deleteSnapshot(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Snapshot?"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              snapshots.removeAt(index);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedFilter == null
        ? snapshots
        : snapshots.where((s) => s.course == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Snapshots'), centerTitle: true),
      body: Column(
        children: [
          // Filter
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButtonFormField<Course?>(
              initialValue: _selectedFilter,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("Filter by course"),
              items: [
                const DropdownMenuItem(value: null, child: Text("All Courses")),
                ...courses.map((c) => DropdownMenuItem(value: c, child: Text(c.name))),
              ],
              onChanged: (val) => setState(() => _selectedFilter = val),
            ),
          ),

          // List
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text("No snapshots yet."))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final snap = filtered[i];
                      final originalIndex = snapshots.indexOf(snap);
                      final firstImg = snap.images.isNotEmpty ? snap.images.first : "";

                      final thumb = firstImg.isEmpty
                          ? const Icon(Icons.image_not_supported, size: 40)
                          : isFilePath(firstImg)
                              ? Image.file(File(firstImg), width: 60, height: 60, fit: BoxFit.cover)
                              : Image.asset(firstImg, width: 60, height: 60, fit: BoxFit.cover);

                      return Card(
                        child: ListTile(
                          leading: thumb,
                          title: Text("${snap.course.name} — ${snap.date}"),
                          subtitle: Text(snap.note, maxLines: 2, overflow: TextOverflow.ellipsis),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SnapshotDetailsPage(index: originalIndex),
                              ),
                            ).then((_) => setState(() {}));
                          },
                          onLongPress: () => _deleteSnapshot(originalIndex),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
