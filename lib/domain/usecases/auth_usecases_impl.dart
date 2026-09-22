import '../../core/typedefs/type_defs.dart';
import '../../data/repositories/auth_repository_interface.dart';
import '../models/user_entity.dart';
import 'auth_usecases_interface.dart';

final class SignUpUseCaseImpl implements ISignUpUseCase {
  final IAuthRepository _repository;
  SignUpUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  Future<UserResult> call({required String email, required String password}) {
    return _repository.signUp(email: email, password: password);
  }
}

final class SignInUseCaseImpl implements ISignInUseCase {
  final IAuthRepository _repository;
  SignInUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  Future<UserResult> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}

final class SignInWithGoogleUseCaseImpl implements ISignInWithGoogleUseCase {
  final IAuthRepository _repository;
  SignInWithGoogleUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  Future<UserResult> call() {
    return _repository.signInWithGoogle();
  }
}

final class SignOutUseCaseImpl implements ISignOutUseCase {
  final IAuthRepository _repository;
  SignOutUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  Future<VoidResult> call() {
    return _repository.signOut();
  }
}

final class GetCurrentUserUseCaseImpl implements IGetCurrentUserUseCase {
  final IAuthRepository _repository;
  GetCurrentUserUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  UserEntity? call() => _repository.currentUser;
}

final class AuthStateChangesUseCaseImpl implements IAuthStateChangesUseCase {
  final IAuthRepository _repository;
  AuthStateChangesUseCaseImpl({required IAuthRepository repository}) : _repository = repository;

  @override
  Stream<UserEntity?> call() => _repository.authStateChanges;
}