import '../../core/typedefs/type_defs.dart';
import '../models/user_entity.dart';
import '../usecases/auth_usecases_interface.dart';
import 'auth_facade_interface.dart';

final class AuthFacadeImpl implements IAuthFacade {
  final ISignUpUseCase _signUpUseCase;
  final ISignInUseCase _signInUseCase;
  final ISignInWithGoogleUseCase _signInWithGoogleUseCase;
  final ISignOutUseCase _signOutUseCase;
  final IGetCurrentUserUseCase _getCurrentUserUseCase;
  final IAuthStateChangesUseCase _authStateChangesUseCase;

  AuthFacadeImpl({
    required ISignUpUseCase signUpUseCase,
    required ISignInUseCase signInUseCase,
    required ISignInWithGoogleUseCase signInWithGoogleUseCase,
    required ISignOutUseCase signOutUseCase,
    required IGetCurrentUserUseCase getCurrentUserUseCase,
    required IAuthStateChangesUseCase authStateChangesUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signOutUseCase = signOutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _authStateChangesUseCase = authStateChangesUseCase;

  @override
  Future<UserResult> criarConta({required String email, required String password}) {
    return _signUpUseCase(email: email, password: password);
  }

  @override
  Future<UserResult> login({required String email, required String password}) {
    return _signInUseCase(email: email, password: password);
  }

  @override
  Future<UserResult> loginComGoogle() => _signInWithGoogleUseCase();

  @override
  Future<VoidResult> logout() => _signOutUseCase();

  @override
  UserEntity? get usuarioAtual => _getCurrentUserUseCase();

  @override
  Stream<UserEntity?> get mudancasDeAutenticacao => _authStateChangesUseCase();
}