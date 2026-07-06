// lib/presentation/widgets/course_dropdown.dart
import 'package:flutter/material.dart';
import '../../domain/models/student_entity.dart';

class CourseDropdown extends StatelessWidget {
  final StudentCourse value;
  final void Function(StudentCourse) onChanged;

  const CourseDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static String label(StudentCourse c) {
    switch (c) {
      case StudentCourse.INFO: return 'INFO — Informática';
      case StudentCourse.MEC:  return 'MEC — Mecânica';
      case StudentCourse.MAMB: return 'MAMB — Meio Ambiente';
      case StudentCourse.PROD: return 'PROD — Produção';
      case StudentCourse.TADS: return 'TADS — Desenvolvimento de Sistemas';
      case StudentCourse.TGA:  return 'TGA — Gestão Ambiental';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Curso *',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonFormField<StudentCourse>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.4)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          items: StudentCourse.values
              .map((c) => DropdownMenuItem(value: c, child: Text(label(c))))
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ],
    );
  }
}