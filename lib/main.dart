import 'package:flutter/material.dart';
// tema
import 'core/theme/app_theme.dart';
// rotas
import 'core/routes/app_routes.dart';
// DI
import 'core/di/dependency_injection.dart';
// views
import 'presentation/views/splash_view.dart';
import 'presentation/views/home_view.dart';
import 'presentation/views/about_view.dart';
import 'presentation/views/students/list_of/students_view.dart';
import 'presentation/views/students/ranking/ranking_view.dart';
import 'presentation/views/students/form/form_student_view.dart';
import 'presentation/views/students/details/student_details_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  runApp(const PiramidGameApp());
}

class PiramidGameApp extends StatelessWidget {
  const PiramidGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeViewModel.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (_) => const SplashView(),
            AppRoutes.home: (_) => const HomeView(),
            AppRoutes.about: (_) => const AboutView(),
            AppRoutes.students: (_) => const StudentsView(),
            AppRoutes.ranking: (_) => const RankingView(),
            AppRoutes.studentForm: (_) => const FormStudentView(),
            AppRoutes.studentDetails: (_) => const StudentDetailsView(),
          },
        );
      },
    );
  }
}
