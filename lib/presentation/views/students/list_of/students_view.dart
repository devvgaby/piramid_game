import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/models/student_entity.dart';
import '../../../layouts/app_shell.dart';
import '../../../widgets/student_card.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/loading_indicator.dart';
import 'students_floating_button.dart';
import '../form/form_student_view.dart';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  @override
  void initState() {
    super.initState();
    studentsViewModel.commands.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: AppRoutes.students,
      child: Watch((context) {
        final students = studentsViewModel.studentsState.state.value;
        final isLoading =
            studentsViewModel.getAllStudentsCommand.isExecuting.value;
        final sorted = [...students]
          ..sort((a, b) => b.legendLevel.compareTo(a.legendLevel));

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alunos',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '${students.length} aluno${students.length != 1 ? 's' : ''} cadastrado${students.length != 1 ? 's' : ''}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6)),
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: () => _openForm(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Novo aluno'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (isLoading)
                const Expanded(child: LoadingIndicator())
              else if (students.isEmpty)
                Expanded(
                  child: EmptyState(
                    icon: Icons.school_outlined,
                    title: 'Nenhum aluno cadastrado ainda',
                    subtitle: 'Comece adicionando o primeiro aluno do ranking.',
                    buttonLabel: 'Cadastrar aluno',
                    onAction: () => _openForm(context),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 420,
                      mainAxisExtent: 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: sorted.length,
                    itemBuilder: (context, i) => StudentCard(
                      student: sorted[i],
                      rank: i + 1,
                      onView: () => _openDetails(context, sorted[i]),
                      onEdit: () => _openForm(context, student: sorted[i]),
                      onDelete: () => _confirmDelete(context, sorted[i]),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  void _openForm(BuildContext context, {StudentEntity? student}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormStudentView(student: student)),
    );
    studentsViewModel.commands.fetchStudents();
  }

  void _openDetails(BuildContext context, StudentEntity student) {
  Navigator.pushNamed(
    context,
    AppRoutes.studentDetails,
    arguments: student,
  );
}

  void _confirmDelete(BuildContext context, StudentEntity student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Deletar aluno'),
        content: Text('Deseja remover "${student.name}" do ranking?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () {
              Navigator.pop(ctx);
              studentsViewModel.commands.deleteStudent(student.id);
            },
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }
}