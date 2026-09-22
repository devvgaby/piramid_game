import '../../core/typedefs/type_defs.dart';
import '../models/user_entity.dart';

abstract interface class IAuthFacade {
  Future<UserResult> criarConta({required String email, required String password});
  Future<UserResult> login({required String email, required String password});
  Future<UserResult> loginComGoogle();
  Future<VoidResult> logout();
  UserEntity? get usuarioAtual;
  Stream<UserEntity?> get mudancasDeAutenticacao;
}