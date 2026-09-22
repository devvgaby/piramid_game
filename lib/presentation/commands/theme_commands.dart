import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/facades/theme_facade_interface.dart';

class GetThemeCommand {
  final IThemeFacade facade;
  final resultSignal = signal<bool?>(null);
  final isExecuting = signal<bool>(false);

  GetThemeCommand(this.facade);

  Future<void> execute(void input) async {
    isExecuting.value = true;
    try {
      final result = await facade.useCases.getTheme();
      resultSignal.value = result;
    } catch (e) {
      resultSignal.value = false;
    } finally {
      isExecuting.value = false;
    }
  }
}

class ToggleThemeCommand {
  final IThemeFacade facade;
  final resultSignal = signal<bool?>(null);
  final isExecuting = signal<bool>(false);

  ToggleThemeCommand(this.facade);

  Future<void> execute(bool current) async {
    isExecuting.value = true;
    try {
      final result = await facade.useCases.toggleTheme(current);
      resultSignal.value = result;
    } catch (e) {
      resultSignal.value = !current;
    } finally {
      isExecuting.value = false;
    }
  }
}