import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/di/dependency_injection.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencyInjection();
  runApp(const PiramidGameApp());
}

class PiramidGameApp extends StatelessWidget {
  const PiramidGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return Watch((context) {
      final mode = themeViewModel.themeMode.value;
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: mode,
        routerConfig: router,
      );
    });
  }
}