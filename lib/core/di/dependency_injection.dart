
import '../../data/services/student_shared_preferences_impl.dart';
import '../../data/services/student_local_storage_interface.dart';
import '../../data/services/theme_shared_preferences_impl.dart';
import '../../data/services/theme_local_storage_interface.dart';

import '../../data/repositories/student_repository_impl.dart';
import '../../data/repositories/student_repository_interface.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../data/repositories/theme_repository_interface.dart';

import '../../domain/usecases/student_usecases_impl.dart';
import '../../domain/usecases/student_usecases_interface.dart';
import '../../domain/usecases/theme_usecases_impl.dart';
import '../../domain/usecases/theme_usecases_interfaces.dart';

import '../../domain/facades/student_facade_impl.dart';
import '../../domain/facades/student_facade_interface.dart';
import '../../domain/facades/theme_facade_impl.dart';
import '../../domain/facades/theme_facade_interface.dart';

import '../theme/theme_controller.dart';
import '../../presentation/commands/theme_commands.dart';
import '../../presentation/controllers/students_view_model.dart';
import '../../presentation/controllers/theme_viewmodel.dart';
import '../../presentation/controllers/splash_viewmodel.dart';

late final ThemeViewModel themeViewModel;
late final StudentsViewModel studentsViewModel;
late final SplashViewModel splashViewModel;

void setupDependencyInjection() {
  final IThemeLocalStorage themeStorage = ThemeSharedPreferencesService();
  final IStudentLocalStorage studentStorage = StudentSharedPreferencesService();

  final IStudentRepository studentRepository = StudentRepositoryImpl(
    localStorage: studentStorage,
  );
  final IThemeRepository themeRepository = ThemeRepositoryImpl(themeStorage);

  final IThemeUseCases themeUseCases = ThemeUseCasesImpl(themeRepository);

  final IGetAllStudentsUseCase getAllStudents = GetAllStudentsUseCaseImpl(
    repository: studentRepository,
  );
  final IGetStudentByIdUseCase getStudentById = GetStudentByIdUseCaseImpl(
    repository: studentRepository,
  );
  final ISaveStudentUseCase saveStudent = SaveStudentUseCaseImpl(
    repository: studentRepository,
  );
  final IUpdateStudentUseCase updateStudent = UpdateStudentUseCaseImpl(
    repository: studentRepository,
  );
  final IDeleteStudentUseCase deleteStudent = DeleteStudentUseCaseImpl(
    repository: studentRepository,
  );

  final IThemeFacade themeFacade = ThemeFacadeImpl(themeUseCases);
  final IStudentFacadeUseCases studentFacade = StudentFacadeUseCasesImpl(
    getAllStudentsUseCase: getAllStudents,
    getStudentByIdUseCase: getStudentById,
    saveStudentUseCase: saveStudent,
    updateStudentUseCase: updateStudent,
    deleteStudentUseCase: deleteStudent,
  );

  final themeController = ThemeController();

  final getThemeCommand = GetThemeCommand(themeFacade);
  final toggleThemeCommand = ToggleThemeCommand(themeFacade);

  themeViewModel = ThemeViewModel(themeController, getThemeCommand, toggleThemeCommand);
  studentsViewModel = StudentsViewModel(studentFacade);
  splashViewModel = SplashViewModel(themeViewModel);
}
