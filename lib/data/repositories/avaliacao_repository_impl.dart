import '../../core/typedefs/type_defs.dart';
import '../../domain/models/avaliacao_entity.dart';
import '../services/avaliacao_firestore_impl.dart';
import 'avaliacao_repository_interface.dart';

final class AvaliacaoRepositoryImpl implements IAvaliacaoRepository {
  final AvaliacaoFirestoreService _service;

  AvaliacaoRepositoryImpl({required AvaliacaoFirestoreService service})
      : _service = service;

  @override
  Future<AvaliacaoResult> salvarAvaliacao(AvaliacaoEntity avaliacao) {
    return _service.salvarAvaliacao(avaliacao);
  }

  @override
  Future<AvaliacaoResult?> buscarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  }) {
    return _service.buscarAvaliacaoExistente(
      avaliadorUid: avaliadorUid,
      pessoaId: pessoaId,
    );
  }

  @override
  Future<ListAvaliacaoResult> buscarAvaliacoesPorAvaliador(String avaliadorUid) {
    return _service.buscarAvaliacoesPorAvaliador(avaliadorUid);
  }

  @override
  Future<ListAvaliacaoResult> buscarAvaliacoesPorPessoa(String pessoaId) {
    return _service.buscarAvaliacoesPorPessoa(pessoaId);
  }

  @override
  Future<ListAvaliacaoResult> buscarTodasAvaliacoes() {
    return _service.buscarTodasAvaliacoes();
  }
}