import '../../core/typedefs/type_defs.dart';
import '../../data/repositories/avaliacao_repository_interface.dart';
import '../models/avaliacao_entity.dart';
import 'avaliacao_usecases_interface.dart';

final class SalvarAvaliacaoUseCaseImpl implements ISalvarAvaliacaoUseCase {
  final IAvaliacaoRepository _repository;
  SalvarAvaliacaoUseCaseImpl({required IAvaliacaoRepository repository})
      : _repository = repository;

  @override
  Future<AvaliacaoResult> call(AvaliacaoEntity avaliacao) {
    return _repository.salvarAvaliacao(avaliacao);
  }
}

final class BuscarAvaliacaoExistenteUseCaseImpl
    implements IBuscarAvaliacaoExistenteUseCase {
  final IAvaliacaoRepository _repository;
  BuscarAvaliacaoExistenteUseCaseImpl({required IAvaliacaoRepository repository})
      : _repository = repository;

  @override
  Future<AvaliacaoResult?> call({
    required String avaliadorUid,
    required String pessoaId,
  }) {
    return _repository.buscarAvaliacaoExistente(
      avaliadorUid: avaliadorUid,
      pessoaId: pessoaId,
    );
  }
}

final class BuscarAvaliacoesPorAvaliadorUseCaseImpl
    implements IBuscarAvaliacoesPorAvaliadorUseCase {
  final IAvaliacaoRepository _repository;
  BuscarAvaliacoesPorAvaliadorUseCaseImpl({required IAvaliacaoRepository repository})
      : _repository = repository;

  @override
  Future<ListAvaliacaoResult> call(String avaliadorUid) {
    return _repository.buscarAvaliacoesPorAvaliador(avaliadorUid);
  }
}

final class BuscarAvaliacoesPorPessoaUseCaseImpl
    implements IBuscarAvaliacoesPorPessoaUseCase {
  final IAvaliacaoRepository _repository;
  BuscarAvaliacoesPorPessoaUseCaseImpl({required IAvaliacaoRepository repository})
      : _repository = repository;

  @override
  Future<ListAvaliacaoResult> call(String pessoaId) {
    return _repository.buscarAvaliacoesPorPessoa(pessoaId);
  }
}

final class BuscarTodasAvaliacoesUseCaseImpl
    implements IBuscarTodasAvaliacoesUseCase {
  final IAvaliacaoRepository _repository;
  BuscarTodasAvaliacoesUseCaseImpl({required IAvaliacaoRepository repository})
      : _repository = repository;

  @override
  Future<ListAvaliacaoResult> call() {
    return _repository.buscarTodasAvaliacoes();
  }
}