import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StudentsFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StudentsFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: const Text('Novo aluno'),
    );
  }
}