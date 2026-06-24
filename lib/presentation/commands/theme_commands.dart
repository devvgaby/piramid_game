import '../../core/patterns/command.dart';
import '../../core/failure/failure.dart';
import '../facade/theme_facade_interface.dart';

class GetThemeCommand extends Command<void, bool, Failure> {
  final IThemeFacade facade;

  GetThemeCommand(this.facade);

  @override
  Future<void> execute(void input) async {
    try {
      final result = await facade.useCases.getTheme();
      resultSignal.value = result;
    } catch (e) {
      setFailure(DefaultFailure(e.toString()));
    }
  }
}

class ToggleThemeCommand extends Command<bool, bool, Failure> {
  final IThemeFacade facade;

  ToggleThemeCommand(this.facade);

  @override
  Future<void> execute(bool input) async {
    try {
      final result = await facade.useCases.toggleTheme(input);
      resultSignal.value = result;
    } catch (e) {
      setFailure(DefaultFailure(e.toString()));
    }
  }
}