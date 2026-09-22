import '../../core/typedefs/type_defs.dart';
import '../models/avaliacao_entity.dart';

abstract interface class ISalvarAvaliacaoUseCase {
  Future<AvaliacaoResult> call(AvaliacaoEntity avaliacao);
}

abstract interface class IBuscarAvaliacaoExistenteUseCase {
  Future<AvaliacaoResult?> call({
    required String avaliadorUid,
    required String pessoaId,
  });
}

abstract interface class IBuscarAvaliacoesPorAvaliadorUseCase {
  Future<ListAvaliacaoResult> call(String avaliadorUid);
}

abstract interface class IBuscarAvaliacoesPorPessoaUseCase {
  Future<ListAvaliacaoResult> call(String pessoaId);
}

abstract interface class IBuscarTodasAvaliacoesUseCase {
  Future<ListAvaliacaoResult> call();
}