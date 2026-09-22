import 'package:go_router/go_router.dart';

import '../di/dependency_injection.dart';
import '../../domain/models/student_entity.dart';
import '../../presentation/views/splash_view.dart';
import '../../presentation/views/home_view.dart';
import '../../presentation/views/about_view.dart';
import '../../presentation/views/login_view.dart';
import '../../presentation/views/signup_view.dart';
import '../../presentation/views/students/list_of/students_view.dart';
import '../../presentation/views/students/ranking/ranking_view.dart';
import '../../presentation/views/students/form/form_student_view.dart';
import '../../presentation/views/students/details/student_details_view.dart';
import '../../presentation/views/students/avaliar/avaliar_pessoa_view.dart';
import 'router_refresh_stream.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const students = '/students';
  static const studentForm = '/students/form';
  static const studentDetails = '/students/details';
  static const studentAvaliar = '/students/avaliar';
  static const ranking = '/ranking';
  static const about = '/about';
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: RouterRefreshStream(authViewModel.authChanges),
    redirect: (context, state) {
      final loggedIn = authViewModel.currentUser.value != null;
      final path = state.matchedLocation;

      if (path == AppRoutes.splash) return null;

      final isAuthPage = path == AppRoutes.login || path == AppRoutes.signup;

      if (!loggedIn && !isAuthPage) {
        return AppRoutes.login;
      }
      if (loggedIn && isAuthPage) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashView()),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginView()),
      GoRoute(path: AppRoutes.signup, builder: (_, __) => const SignupView()),
      GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeView()),
      GoRoute(path: AppRoutes.about, builder: (_, __) => const AboutView()),
      GoRoute(
        path: AppRoutes.students,
        builder: (_, __) => const StudentsView(),
      ),
      GoRoute(
        path: AppRoutes.studentForm,
        builder: (_, state) =>
            FormStudentView(student: state.extra as StudentEntity?),
      ),
      GoRoute(
        path: AppRoutes.studentDetails,
        builder: (_, state) =>
            StudentDetailsView(student: state.extra as StudentEntity),
      ),
      GoRoute(
        path: AppRoutes.studentAvaliar,
        builder: (_, state) =>
            AvaliarPessoaView(pessoa: state.extra as StudentEntity),
      ),
      GoRoute(path: AppRoutes.ranking, builder: (_, __) => const RankingView()),
    ],
  );
}