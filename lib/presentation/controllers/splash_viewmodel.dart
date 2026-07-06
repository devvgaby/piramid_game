import 'theme_viewmodel.dart';

class SplashViewModel {
  final ThemeViewModel themeViewModel;

  SplashViewModel(this.themeViewModel);

  Future<void> initialize() async {
    await themeViewModel.loadTheme();
  }
}
