import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../layouts/app_shell.dart';
import '../../../widgets/ranking_card.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/loading_indicator.dart';
import '../form/form_student_view.dart';

class RankingView extends StatefulWidget {
  const RankingView({super.key});

  @override
  State<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  @override
  void initState() {
    super.initState();
    studentsViewModel.commands.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: AppRoutes.ranking,
      child: Watch((context) {
        final students = [...studentsViewModel.studentsState.state.value]
          ..sort((a, b) => b.legendLevel.compareTo(a.legendLevel));
        final isLoading =
            studentsViewModel.getAllStudentsCommand.isExecuting.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events, size: 36, color: AppColors.lenda),
                  const SizedBox(width: 12),
                  Text('Ranking — Nível Lenda',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Classificação automática pela soma dos 15 critérios (15–75 pontos).',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.55)),
              ),
              const SizedBox(height: 24),
              if (isLoading)
                const SizedBox(height: 200, child: LoadingIndicator())
              else if (students.isEmpty)
                EmptyState(
                  icon: Icons.emoji_events_outlined,
                  title: 'Nenhum aluno cadastrado.',
                  buttonLabel: 'Cadastrar primeiro aluno',
                  onAction: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const FormStudentView())),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: students.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      RankingCard(student: students[i], position: i + 1),
                ),
            ],
          ),
        );
      }),
    );
  }
}