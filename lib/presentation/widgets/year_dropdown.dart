import 'package:flutter/material.dart';

class YearDropdown extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  const YearDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(currentYear - 1997, (i) => currentYear - i);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Turma / Ano *',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
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
          items: years
              .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ],
    );
  }
}