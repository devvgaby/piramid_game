import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/models/user_entity.dart';

final class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  UserEntity? _mapUser(User? user) {
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  UserEntity? get currentUser => _mapUser(_auth.currentUser);

  Stream<UserEntity?> get authStateChanges =>
      _auth.authStateChanges().map(_mapUser);

  Future<UserResult> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _mapUser(credential.user);
      if (user == null) return Error(AuthFailure('Falha ao criar usuário'));
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Error(AuthFailure(_translateError(e.code)));
    } catch (e) {
      return Error(AuthFailure('Erro inesperado: $e'));
    }
  }

  Future<UserResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _mapUser(credential.user);
      if (user == null) return Error(AuthFailure('Falha ao entrar'));
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Error(AuthFailure(_translateError(e.code)));
    } catch (e) {
      return Error(AuthFailure('Erro inesperado: $e'));
    }
  }

    Future<UserResult> signInWithGoogle() async {
    try {
      final googleProvider = GoogleAuthProvider();
      final credential = await _auth.signInWithPopup(googleProvider);
      final user = _mapUser(credential.user);
      if (user == null) return Error(AuthFailure('Falha ao entrar com Google'));
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Error(AuthFailure(_translateError(e.code)));
    } catch (e) {
      return Error(AuthFailure('Erro ao entrar com Google: $e'));
    }
  }

  Future<VoidResult> signOut() async {
    try {
      await _auth.signOut();
      return Success(null);
    } catch (e) {
      return Error(AuthFailure('Erro ao sair: $e'));
    }
  }

  String _translateError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este e-mail já está em uso';
      case 'invalid-email':
        return 'E-mail inválido';
      case 'weak-password':
        return 'Senha muito fraca (mínimo 6 caracteres)';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou senha incorretos';
      case 'user-disabled':
        return 'Esta conta foi desativada';
      default:
        return 'Erro de autenticação ($code)';
    }
  }
}