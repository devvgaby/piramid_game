import '../../core/typedefs/type_defs.dart';
import '../models/avaliacao_entity.dart';
import '../usecases/avaliacao_usecases_interface.dart';
import 'avaliacao_facade_interface.dart';

final class AvaliacaoFacadeImpl implements IAvaliacaoFacade {
  final ISalvarAvaliacaoUseCase _salvarAvaliacaoUseCase;
  final IBuscarAvaliacaoExistenteUseCase _buscarAvaliacaoExistenteUseCase;
  final IBuscarAvaliacoesPorAvaliadorUseCase _buscarPorAvaliadorUseCase;
  final IBuscarAvaliacoesPorPessoaUseCase _buscarPorPessoaUseCase;
  final IBuscarTodasAvaliacoesUseCase _buscarTodasUseCase;

  AvaliacaoFacadeImpl({
    required ISalvarAvaliacaoUseCase salvarAvaliacaoUseCase,
    required IBuscarAvaliacaoExistenteUseCase buscarAvaliacaoExistenteUseCase,
    required IBuscarAvaliacoesPorAvaliadorUseCase buscarPorAvaliadorUseCase,
    required IBuscarAvaliacoesPorPessoaUseCase buscarPorPessoaUseCase,
    required IBuscarTodasAvaliacoesUseCase buscarTodasUseCase,
  })  : _salvarAvaliacaoUseCase = salvarAvaliacaoUseCase,
        _buscarAvaliacaoExistenteUseCase = buscarAvaliacaoExistenteUseCase,
        _buscarPorAvaliadorUseCase = buscarPorAvaliadorUseCase,
        _buscarPorPessoaUseCase = buscarPorPessoaUseCase,
        _buscarTodasUseCase = buscarTodasUseCase;

  @override
  Future<AvaliacaoResult> avaliar(AvaliacaoEntity avaliacao) {
    return _salvarAvaliacaoUseCase(avaliacao);
  }

  @override
  Future<AvaliacaoResult?> consultarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  }) {
    return _buscarAvaliacaoExistenteUseCase(
      avaliadorUid: avaliadorUid,
      pessoaId: pessoaId,
    );
  }

  @override
  Future<ListAvaliacaoResult> carregarMinhasAvaliacoes(String avaliadorUid) {
    return _buscarPorAvaliadorUseCase(avaliadorUid);
  }

  @override
  Future<ListAvaliacaoResult> carregarAvaliacoesDaPessoa(String pessoaId) {
    return _buscarPorPessoaUseCase(pessoaId);
  }

  @override
  Future<ListAvaliacaoResult> carregarTodasAvaliacoes() {
    return _buscarTodasUseCase();
  }
}