import '../../core/typedefs/type_defs.dart';
import '../../domain/models/avaliacao_entity.dart';

abstract interface class IAvaliacaoRepository {
  Future<AvaliacaoResult> salvarAvaliacao(AvaliacaoEntity avaliacao);
  Future<AvaliacaoResult?> buscarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  });
  Future<ListAvaliacaoResult> buscarAvaliacoesPorAvaliador(String avaliadorUid);
  Future<ListAvaliacaoResult> buscarAvaliacoesPorPessoa(String pessoaId);
  Future<ListAvaliacaoResult> buscarTodasAvaliacoes();
}