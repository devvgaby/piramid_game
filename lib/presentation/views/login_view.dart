import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/routes/app_routes.dart';
import '../widgets/input_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    setState(() => _errorMessage = null);

    final result = await authViewModel.signInCommand.executeWith((
      email: _emailController.text.trim(),
      password: _passwordController.text,
    ));

    if (!mounted) return;

    result.fold(
      onSuccess: (_) {
        context.go(AppRoutes.home);
      },
      onFailure: (failure) {
        setState(() => _errorMessage = failure.msg);
      },
    );
  }

  Future<void> _loginComGoogle() async {
    setState(() => _errorMessage = null);

    final result = await authViewModel.signInWithGoogleCommand.call();

    if (!mounted) return;

    result.fold(
      onSuccess: (_) {
        context.go(AppRoutes.home);
      },
      onFailure: (failure) {
        setState(() => _errorMessage = failure.msg);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
                  const SizedBox(height: 12),
                  Text(
                    'PiramidGame IFPR-Pgua',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 32),
                  InputTextField(
                    label: 'E-mail',
                    controller: _emailController,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  InputTextField(
                    label: 'Senha',
                    controller: _passwordController,
                    isRequired: true,
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Watch((context) {
                    final isLoading = authViewModel.signInCommand.isExecuting.value;
                    return FilledButton(
                      onPressed: isLoading ? null : _login,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Entrar'),
                    );
                  }),
                  const SizedBox(height: 12),
                  Watch((context) {
                    final isLoading =
                        authViewModel.signInWithGoogleCommand.isExecuting.value;
                    return OutlinedButton.icon(
                      onPressed: isLoading ? null : _loginComGoogle,
                      icon: isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.g_mobiledata, size: 28),
                      label: const Text('Entrar com Google'),
                    );
                  }),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.push(AppRoutes.signup);
                    },
                    child: const Text('Não tem conta? Criar conta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}