import 'package:signals_flutter/signals_flutter.dart';

import '../../domain/facades/auth_facade_interface.dart';
import '../../domain/models/user_entity.dart';
import '../commands/auth_commands.dart';

class AuthViewModel {
  final IAuthFacade _facade;

  final SignUpCommand signUpCommand;
  final SignInCommand signInCommand;
  final SignInWithGoogleCommand signInWithGoogleCommand;
  final SignOutCommand signOutCommand;

  final currentUser = signal<UserEntity?>(null);

  AuthViewModel(this._facade)
      : signUpCommand = SignUpCommand(_facade),
        signInCommand = SignInCommand(_facade),
        signInWithGoogleCommand = SignInWithGoogleCommand(_facade),
        signOutCommand = SignOutCommand(_facade) {
    currentUser.value = _facade.usuarioAtual;
    _facade.mudancasDeAutenticacao.listen((user) {
      currentUser.value = user;
    });
  }

  bool get isAuthenticated => currentUser.value != null;
  Stream<UserEntity?> get authChanges => _facade.mudancasDeAutenticacao;

  Future<bool> cadastrar({required String email, required String password}) async {
    final result = await signUpCommand.executeWith((email: email, password: password));
    return result.isSuccess;
  }

  Future<bool> entrar({required String email, required String password}) async {
    final result = await signInCommand.executeWith((email: email, password: password));
    return result.isSuccess;
  }

    Future<bool> entrarComGoogle() async {
    final result = await signInWithGoogleCommand.call();
    return result.isSuccess;
  }

  Future<void> sair() async {
    await signOutCommand.call();
  }
}