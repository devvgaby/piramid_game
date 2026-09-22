import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/facades/avaliacao_facade_interface.dart';
import '../../domain/models/avaliacao_entity.dart';

final class AvaliarPessoaCommand
    extends ParameterizedCommand<AvaliacaoEntity, Failure, AvaliacaoEntity> {
  final IAvaliacaoFacade _facade;

  AvaliarPessoaCommand(this._facade);

  @override
  Future<AvaliacaoResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Avaliação ausente.'));
    }
    return await _facade.avaliar(parameter!);
  }
}

final class CarregarMinhasAvaliacoesCommand
    extends ParameterizedCommand<List<AvaliacaoEntity>, Failure, String> {
  final IAvaliacaoFacade _facade;

  CarregarMinhasAvaliacoesCommand(this._facade);

  @override
  Future<ListAvaliacaoResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Usuário ausente.'));
    }
    return await _facade.carregarMinhasAvaliacoes(parameter!);
  }
}

final class CarregarTodasAvaliacoesCommand
    extends Command<List<AvaliacaoEntity>, Failure> {
  final IAvaliacaoFacade _facade;

  CarregarTodasAvaliacoesCommand(this._facade);

  @override
  Future<ListAvaliacaoResult> execute() async {
    return await _facade.carregarTodasAvaliacoes();
  }
}