import 'package:flutter/material.dart';

class BirthDatePicker extends StatelessWidget {
  final DateTime? value;
  final void Function(DateTime) onChanged;

  const BirthDatePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime(2008),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null) onChanged(picked);
  }

  String get _formatted {
    if (value == null) return 'Selecione uma data';
    return '${value!.day.toString().padLeft(2, '0')}/'
        '${value!.month.toString().padLeft(2, '0')}/'
        '${value!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Data de nascimento *',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _pick(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                const SizedBox(width: 12),
                Text(
                  _formatted,
                  style: TextStyle(
                    color: value == null
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}