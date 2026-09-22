import '../../core/typedefs/type_defs.dart';
import '../../domain/models/user_entity.dart';
import '../services/auth_service.dart';
import 'auth_repository_interface.dart';

final class AuthRepositoryImpl implements IAuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  UserEntity? get currentUser => _authService.currentUser;

  @override
  Stream<UserEntity?> get authStateChanges => _authService.authStateChanges;

  @override
  Future<UserResult> signUp({required String email, required String password}) {
    return _authService.signUp(email: email, password: password);
  }

  @override
  Future<UserResult> signIn({required String email, required String password}) {
    return _authService.signIn(email: email, password: password);
  }

  @override
  Future<UserResult> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  @override
  Future<VoidResult> signOut() {
    return _authService.signOut();
  }
}