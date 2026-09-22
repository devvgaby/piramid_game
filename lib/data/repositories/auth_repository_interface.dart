import '../../core/typedefs/type_defs.dart';
import '../../domain/models/user_entity.dart';

abstract interface class IAuthRepository {
  UserEntity? get currentUser;
  Stream<UserEntity?> get authStateChanges;
  Future<UserResult> signUp({required String email, required String password});
  Future<UserResult> signIn({required String email, required String password});
  Future<UserResult> signInWithGoogle();
  Future<VoidResult> signOut();
}