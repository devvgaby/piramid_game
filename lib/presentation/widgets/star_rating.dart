import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final int value;
  final void Function(int)? onChanged;
  final double size;

  const StarRating({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < value;
        final star = Icon(
          filled ? Icons.star : Icons.star_border,
          size: size,
          color: filled ? AppColors.secondary : Colors.grey.shade500,
        );
        if (onChanged == null) return star;
        return GestureDetector(
          onTap: () => onChanged!(i + 1),
          child: star,
        );
      }),
    );
  }
}