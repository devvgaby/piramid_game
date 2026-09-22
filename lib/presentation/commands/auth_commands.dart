import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/facades/auth_facade_interface.dart';
import '../../domain/models/user_entity.dart';

final class SignUpCommand
    extends ParameterizedCommand<UserEntity, Failure, LoginParams> {
  final IAuthFacade _facade;

  SignUpCommand(this._facade);

  @override
  Future<UserResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Dados de cadastro ausentes.'));
    }
    return await _facade.criarConta(
      email: parameter!.email,
      password: parameter!.password,
    );
  }
}

final class SignInCommand
    extends ParameterizedCommand<UserEntity, Failure, LoginParams> {
  final IAuthFacade _facade;

  SignInCommand(this._facade);

  @override
  Future<UserResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Dados de login ausentes.'));
    }
    return await _facade.login(
      email: parameter!.email,
      password: parameter!.password,
    );
  }
}

final class SignInWithGoogleCommand extends Command<UserEntity, Failure> {
  final IAuthFacade _facade;

  SignInWithGoogleCommand(this._facade);

  @override
  Future<UserResult> execute() async {
    return await _facade.loginComGoogle();
  }
}

final class SignOutCommand extends Command<void, Failure> {
  final IAuthFacade _facade;

  SignOutCommand(this._facade);

  @override
  Future<VoidResult> execute() async {
    return await _facade.logout();
  }
}