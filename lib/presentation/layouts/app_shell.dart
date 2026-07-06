import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/di/dependency_injection.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String? activeRoute;
  final bool showBackButton;

  const AppShell({
    super.key,
    required this.child,
    this.activeRoute,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Row(
          children: [
            Icon(Icons.emoji_events),
            SizedBox(width: 8),
            Text("PiramidGame IFPR-Pgua"),
          ],
        ),
        actions: [
          IconButton(
            tooltip: "Alunos",
            color: activeRoute == AppRoutes.students
                ? theme.colorScheme.primary
                : null,
            icon: const Icon(Icons.people),
            onPressed: () {
              if (activeRoute != AppRoutes.students) {
                Navigator.pushReplacementNamed(context, AppRoutes.students);
              }
            },
          ),
          IconButton(
            tooltip: "Ranking",
            color: activeRoute == AppRoutes.ranking
                ? theme.colorScheme.primary
                : null,
            icon: const Icon(Icons.emoji_events),
            onPressed: () {
              if (activeRoute != AppRoutes.ranking) {
                Navigator.pushReplacementNamed(context, AppRoutes.ranking);
              }
            },
          ),
          IconButton(
            tooltip: "Sobre",
            color: activeRoute == AppRoutes.about
                ? theme.colorScheme.primary
                : null,
            icon: const Icon(Icons.info),
            onPressed: () {
              if (activeRoute != AppRoutes.about) {
                Navigator.pushReplacementNamed(context, AppRoutes.about);
              }
            },
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeViewModel.themeMode,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                tooltip: isDark ? "Modo claro" : "Modo escuro",
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => themeViewModel.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: child,
    );
  }
}