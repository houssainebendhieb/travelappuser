import 'package:flutter/material.dart';

Widget offerItem(IconData icon, String label) {
  return Column(
    children: [
      Icon(icon, size: 36, color: Colors.blue),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 16)),
    ],
  );
}
