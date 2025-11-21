// lib/models/snapshot.dart
import 'course.dart';

class Snapshot {
  List<String> images; // multiple image paths
  String note;
  Course course;
  String date;

  Snapshot({
    required this.images,
    required this.note,
    required this.course,
    required this.date,
  });

  @override
  String toString() => '${course.name} - $date';
}
