import 'package:flutter/material.dart';
import 'package:piramid_game/presentation/layouts/app_shell.dart';
import '../../../core/routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(child: HomeBody());
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Alunos", style: theme.textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text("0 alunos cadastrados", style: theme.textTheme.bodySmall),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.students),
            icon: const Icon(Icons.add),
            label: const Text("Novo aluno"),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 70),
                  SizedBox(height: 12),
                  Text("Nenhum aluno cadastrado ainda", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text(
                    "Comece adicionando o primeiro aluno do ranking.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
