import 'package:flutter/material.dart';

class StudentAttributeTitle extends StatelessWidget {
  final String label;

  const StudentAttributeTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      overflow: TextOverflow.ellipsis,
    );
  }
}