import 'dart:io';
import 'package:flutter/material.dart';

import '../snapshot_store.dart';
import '../utils/file_utils.dart';


class SnapshotDetailsPage extends StatelessWidget {
  final int index;

  const SnapshotDetailsPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final snap = snapshots[index];

    return Scaffold(
      appBar: AppBar(title: const Text("Snapshot Details"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (snap.images.isNotEmpty)
              isFilePath(snap.images.first)
                  ? Image.file(File(snap.images.first),
                      width: double.infinity, height: 250, fit: BoxFit.cover)
                  : Image.asset(
                      snap.images.first,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),

            const SizedBox(height: 16),

            Text("Course: ${snap.course.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Date: ${snap.date}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            const Text("Note",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(snap.note, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
