import 'package:flutter/foundation.dart';
import '../../domain/facades/theme_facade_interface.dart';

class GetThemeCommand {
  final IThemeFacade facade;
  final ValueNotifier<bool?> resultSignal = ValueNotifier(null);
  final ValueNotifier<bool> isExecuting = ValueNotifier(false);

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
  final ValueNotifier<bool?> resultSignal = ValueNotifier(null);
  final ValueNotifier<bool> isExecuting = ValueNotifier(false);

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
