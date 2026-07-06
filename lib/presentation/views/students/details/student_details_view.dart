import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/models/student_entity.dart';
import '../../../layouts/app_shell.dart';
import '../../../widgets/star_rating.dart';
import '../../../widgets/student_attribute_title.dart';
import '../form/form_student_view.dart';

class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final student =
        ModalRoute.of(context)!.settings.arguments as StudentEntity;

    return AppShell(
      showBackButton: true,
      child: SingleChildScrollView(
        child: _Body(student: student),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final StudentEntity student;
  const _Body({required this.student});

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

  List<Color> get _gradient {
    final l = student.legendLevel;
    if (l <= 24) return [const Color(0xFF95A5A6), const Color(0xFF7F8C8D)];
    if (l <= 34) return [const Color(0xFF27AE60), const Color(0xFF1E8449)];
    if (l <= 44) return [const Color(0xFF2980B9), const Color(0xFF1A5276)];
    if (l <= 54) return [const Color(0xFF8E44AD), const Color(0xFF6C3483)];
    if (l <= 64) return [const Color(0xFFFFD700), const Color(0xFFF39C12)];
    if (l <= 70) return [const Color(0xFF00D2FF), const Color(0xFF0099CC)];
    return [const Color(0xFFEB02F7), const Color(0xFF9B59B6)];
  }

  String get _initials {
    final parts = student.name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return student.name.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final criterios = <String, int>{
      'Resenha': student.resenha,
      'Presença VIP': student.presencaVip,
      'Aura': student.aura,
      'Modo Parceiro': student.modoParceiro,
      'Carisma Natural': student.carismaNatural,
      'Humor de Milhões': student.humorMilhoes,
      'Energia de Grupo': student.energiaGrupo,
      'Criatividade Caótica': student.criatividadeCaotica,
      'Modo Atleta': student.modoAtleta,
      'Talento de Palco': student.talentoPalco,
      'Drip Escolar': student.dripEscolar,
      'Coração de Dorama': student.coracaoDorama,
      'Queridinho dos Professores': student.queridinhoProfessores,
      'Cérebro Turbo': student.cerebroTurbo,
      'Caos Controlado': student.caosControlado,
    };

    return Column(
      children: [
        // Header gradiente
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => FormStudentView(student: student))),
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Editar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(_initials,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(student.name,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              if (student.nickname.isNotEmpty)
                Text('"${student.nickname}"',
                    style: TextStyle(
                        color: theme.colorScheme.onSurface.withOpacity(0.5))),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8, runSpacing: 6,
                children: [
                  _Tag(student.course.displayName),
                  _Tag('Turma ${student.classYear}'),
                  _Tag(
                    'Nasc. ${student.birthDate.day.toString().padLeft(2, '0')}/${student.birthDate.month.toString().padLeft(2, '0')}/${student.birthDate.year}',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Card nível
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NÍVEL LENDA',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: theme.colorScheme.onSurface.withOpacity(0.5))),
                        Row(
                          children: [
                            Text('${student.legendLevel}',
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: _levelColor)),
                            Text('/75',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(0.35))),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _levelColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(student.levelName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _levelColor, fontSize: 16)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('Critérios',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
                children: criterios.entries.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: StudentAttributeTitle(label: e.key)),
                        StarRating(value: e.value, size: 16),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}