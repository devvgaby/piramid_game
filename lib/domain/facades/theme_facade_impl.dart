import 'theme_facade_interface.dart';
import '../usecases/theme_usecases_interfaces.dart';

class ThemeFacadeImpl implements IThemeFacade {
  @override
  final IThemeUseCases useCases;

  ThemeFacadeImpl(this.useCases);

  ThemeFacadeImpl.simple(IThemeUseCases useCases) : useCases = useCases;
}