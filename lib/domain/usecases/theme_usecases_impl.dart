import 'theme_usecases_interfaces.dart';
import '../../data/repositories/theme_repository_interface.dart';

class ThemeUseCasesImpl implements IThemeUseCases {
  final IThemeRepository repository;

  ThemeUseCasesImpl(this.repository);

  @override
  Future<bool> getTheme() {
    return repository.getTheme();
  }

  @override
  Future<bool> toggleTheme(bool current) async {
    final newValue = !current;
    await repository.saveTheme(newValue);
    return newValue;
  }
}
