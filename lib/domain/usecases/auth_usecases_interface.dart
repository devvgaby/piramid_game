import '../../core/typedefs/type_defs.dart';
import '../models/user_entity.dart';

abstract interface class ISignUpUseCase {
  Future<UserResult> call({required String email, required String password});
}

abstract interface class ISignInUseCase {
  Future<UserResult> call({required String email, required String password});
}

abstract interface class ISignInWithGoogleUseCase {
  Future<UserResult> call();
}

abstract interface class ISignOutUseCase {
  Future<VoidResult> call();
}

abstract interface class IGetCurrentUserUseCase {
  UserEntity? call();
}

abstract interface class IAuthStateChangesUseCase {
  Stream<UserEntity?> call();
}