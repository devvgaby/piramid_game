import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/student_entity.dart';

class RankingCard extends StatelessWidget {
  final StudentEntity student;
  final int position;

  const RankingCard({
    super.key,
    required this.student,
    required this.position,
  });

  Color get _levelColor {
    final l = student.legendLevel;
    if (l <= 24) return AppColors.mortal;
    if (l <= 34) return AppColors.guerreiro;
    if (l <= 44) return AppColors.elite;
    if (l <= 54) return AppColors.mestre;
    if (l <= 64) return AppColors.lenda;
    if (l <= 70) return AppColors.aura;
    return AppColors.chaos;
  }

  Widget _positionBadge() {
    switch (position) {
      case 1:
        return const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.lenda,
          child: Text('1',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        );
      case 2:
        return CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade400,
          child: const Text('2',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        );
      case 3:
        return const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFCD7F32),
          child: Text('3',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        );
      default:
        return CircleAvatar(
          radius: 22,
          backgroundColor: Colors.transparent,
          child: Text('$position',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        );
    }
  }

  String get _medal {
    switch (position) {
      case 1: return '🥇';
      case 2: return '🥈';
      case 3: return '🥉';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTop3 = position <= 3;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isTop3
            ? _levelColor.withOpacity(isDark ? 0.12 : 0.08)
            : (isDark ? AppColors.cardDark : AppColors.cardLight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTop3
              ? _levelColor.withOpacity(0.4)
              : (isDark ? AppColors.borderDark : AppColors.borderLight),
          width: isTop3 ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          _positionBadge(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('"${student.nickname}"',
                        style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withOpacity(0.5))),
                    const SizedBox(width: 8),
                    _Tag(student.course.displayName),
                    const SizedBox(width: 6),
                    _Tag('${student.classYear}'),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(student.levelName.toUpperCase(),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _levelColor,
                      letterSpacing: 1)),
              Row(
                children: [
                  Text('${student.legendLevel}',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _levelColor)),
                  if (_medal.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Text(_medal, style: const TextStyle(fontSize: 22)),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}