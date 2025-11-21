import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/snapshot.dart';
import '../snapshot_store.dart';
import '../course_store.dart';
import '../models/course.dart';
import '../utils/date_utils.dart';

class AddSnapshotPage extends StatefulWidget {
  const AddSnapshotPage({super.key});

  @override
  State<AddSnapshotPage> createState() => _AddSnapshotPageState();
}

class _AddSnapshotPageState extends State<AddSnapshotPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Course? _selectedCourse;
  List<File> _pickedImages = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = todayDate();
    if (courses.isNotEmpty) {
      _selectedCourse = courses.first;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile>? files = await _picker.pickMultiImage();

    if (files != null && files.isNotEmpty) {
      setState(() {
        _pickedImages = files.map((f) => File(f.path)).toList();
      });
    }
  }

  void _saveSnapshot() {
    if (_pickedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please pick at least one image.")),
      );
      return;
    }

    if (_selectedCourse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a course.")),
      );
      return;
    }

    final note = _noteController.text.trim();
    final date = _dateController.text.trim();

    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a note.")),
      );
      return;
    }

    snapshots.add(
      Snapshot(
        images: _pickedImages.map((f) => f.path).toList(),
        note: note,
        course: _selectedCourse!,
        date: date,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Snapshot saved.")),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Snapshot'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Thumbnails
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: _pickedImages.isEmpty
                ? const Center(
                    child: Text("No images selected", style: TextStyle(color: Colors.grey)),
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: _pickedImages.map((file) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.file(
                          file,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: _pickImages,
            icon: const Icon(Icons.photo_library),
            label: const Text("Pick Images"),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<Course>(
            initialValue: _selectedCourse,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Course",
            ),
            items: courses.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c.name),
              );
            }).toList(),
            onChanged: (c) {
              setState(() => _selectedCourse = c);
            },
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Date (auto, editable)",
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Note",
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveSnapshot,
              child: const Text("Save Snapshot", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
