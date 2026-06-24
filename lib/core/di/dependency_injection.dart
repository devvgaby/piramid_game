import 'package:auto_injector/auto_injector.dart';

import '../../data/services/theme_local_storage_interface.dart';
import '../../data/services/theme_shared_preferences_impl.dart';
import '../../data/repositories/theme_repository_interface.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../domain/usecases/theme_usecases_interfaces.dart';
import '../../domain/usecases/theme_usecases_impl.dart';
import '../../domain/facades/theme_facade_interface.dart';
import '../../domain/facades/theme_facade_impl.dart';
import '../../presentation/theme/theme_commands.dart';
import '../../presentation/theme/theme_viewmodel.dart';

// ====================== STUDENT ======================
import '../../data/services/student_local_storage_interface.dart';
import '../../data/services/student_shared_preferences_impl.dart';

import '../../data/repositories/student_repository_interface.dart';
import '../../data/repositories/student_repository_impl.dart';

import '../../domain/usecases/student_usecases_interface.dart';
import '../../domain/usecases/student_usecases_impl.dart';

import '../../domain/facades/student_facade_interface.dart';
import '../../domain/facades/student_facade_impl.dart';

import '../../presentation/controllers/student_commands.dart';
import '../../presentation/controllers/students_viewmodel.dart';

final injector = AutoInjector();

void setupDependencyInjection() {

  injector.addSingleton<IThemeLocalStorage>(
    ThemeSharedPreferences.new,
  );

  injector.addSingleton<IThemeRepository>(
    ThemeRepositoryImpl.new,
  );

  injector.addSingleton<IThemeUseCases>(
    ThemeUseCasesImpl.new,
  );

  injector.addSingleton<IThemeFacade>(
    ThemeFacadeImpl.new,
  );

  injector.addSingleton<ThemeViewModel>(() {
    final facade = injector.get<IThemeFacade>();

    return ThemeViewModel(
      getThemeCommand: GetThemeCommand(facade),
      toggleThemeCommand: ToggleThemeCommand(facade),
    );
  });

  injector.addSingleton<IStudentLocalStorage>(
    StudentSharedPreferences.new,
  );

  injector.addSingleton<IStudentRepository>(
    StudentRepositoryImpl.new,
  );

  injector.addSingleton<IStudentUseCases>(
    StudentUseCasesImpl.new,
  );

  injector.addSingleton<IStudentFacade>(
    StudentFacadeImpl.new,
  );

  injector.addSingleton<StudentsViewModel>(() {
    final facade = injector.get<IStudentFacade>();

    return StudentsViewModel(facade);
  });

  injector.commit();
}