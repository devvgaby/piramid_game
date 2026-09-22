import '../../core/typedefs/type_defs.dart';
import '../models/avaliacao_entity.dart';

abstract interface class IAvaliacaoFacade {
  Future<AvaliacaoResult> avaliar(AvaliacaoEntity avaliacao);
  Future<AvaliacaoResult?> consultarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  });
  Future<ListAvaliacaoResult> carregarMinhasAvaliacoes(String avaliadorUid);
  Future<ListAvaliacaoResult> carregarAvaliacoesDaPessoa(String pessoaId);
  Future<ListAvaliacaoResult> carregarTodasAvaliacoes();
}