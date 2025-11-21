import 'package:flutter/material.dart';

Widget customButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: 220,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 18)),
    ),
  );
}

Widget vSpace(double h) => SizedBox(height: h);
Widget hSpace(double w) => SizedBox(width: w);
