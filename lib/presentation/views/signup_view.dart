import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/routes/app_routes.dart';
import '../widgets/input_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _signup() async {
    setState(() => _errorMessage = null);

    final result = await authViewModel.signUpCommand.executeWith((
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
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
                    hint: 'Mínimo 6 caracteres',
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
                    final isLoading = authViewModel.signUpCommand.isExecuting.value;
                    return FilledButton(
                      onPressed: isLoading ? null : _signup,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Criar conta'),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}