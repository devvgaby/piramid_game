import 'package:signals_flutter/signals_flutter.dart';

import '../../domain/facades/avaliacao_facade_interface.dart';
import '../../domain/models/avaliacao_entity.dart';
import '../../domain/models/student_entity.dart';
import '../commands/avaliacao_commands.dart';

class RankingEntry {
  final StudentEntity pessoa;
  final double pontuacao;
  final int quantidadeAvaliacoes;

  RankingEntry({
    required this.pessoa,
    required this.pontuacao,
    required this.quantidadeAvaliacoes,
  });
}

class AvaliacaoViewModel {
  final IAvaliacaoFacade _facade;

  final AvaliarPessoaCommand avaliarPessoaCommand;
  final CarregarMinhasAvaliacoesCommand carregarMinhasAvaliacoesCommand;
  final CarregarTodasAvaliacoesCommand carregarTodasAvaliacoesCommand;

  final minhasAvaliacoes = signal<List<AvaliacaoEntity>>([]);
  final todasAvaliacoes = signal<List<AvaliacaoEntity>>([]);

  AvaliacaoViewModel(this._facade)
      : avaliarPessoaCommand = AvaliarPessoaCommand(_facade),
        carregarMinhasAvaliacoesCommand = CarregarMinhasAvaliacoesCommand(_facade),
        carregarTodasAvaliacoesCommand = CarregarTodasAvaliacoesCommand(_facade);

  Future<AvaliacaoEntity?> buscarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  }) async {
    final result = await _facade.consultarAvaliacaoExistente(
      avaliadorUid: avaliadorUid,
      pessoaId: pessoaId,
    );
    if (result == null) return null;
    return result.fold(onSuccess: (a) => a, onFailure: (_) => null);
  }

  Future<void> carregarMinhasAvaliacoes(String avaliadorUid) async {
    final result = await carregarMinhasAvaliacoesCommand.executeWith(avaliadorUid);
    result.fold(
      onSuccess: (lista) => minhasAvaliacoes.value = lista,
      onFailure: (_) => minhasAvaliacoes.value = [],
    );
  }

  Future<void> carregarTodasAvaliacoes() async {
    final result = await carregarTodasAvaliacoesCommand.call();
    result.fold(
      onSuccess: (lista) => todasAvaliacoes.value = lista,
      onFailure: (_) => todasAvaliacoes.value = [],
    );
  }

  StudentEntity? _buscarPessoa(List<StudentEntity> pessoas, String id) {
    for (final p in pessoas) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Ranking pessoal: só as avaliações feitas pelo usuário autenticado.
  List<RankingEntry> rankingPessoal(List<StudentEntity> pessoas) {
    final entries = <RankingEntry>[];

    for (final avaliacao in minhasAvaliacoes.value) {
      final pessoa = _buscarPessoa(pessoas, avaliacao.pessoaId);
      if (pessoa == null) continue;

      entries.add(RankingEntry(
        pessoa: pessoa,
        pontuacao: avaliacao.pontuacaoTotal.toDouble(),
        quantidadeAvaliacoes: 1,
      ));
    }

    entries.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));
    return entries;
  }

  /// Ranking global: média das avaliações recebidas por cada pessoa,
  /// considerando avaliações de todos os usuários.
  List<RankingEntry> rankingGlobal(List<StudentEntity> pessoas) {
    final Map<String, List<AvaliacaoEntity>> porPessoa = {};

    for (final avaliacao in todasAvaliacoes.value) {
      porPessoa.putIfAbsent(avaliacao.pessoaId, () => []).add(avaliacao);
    }

    final entries = <RankingEntry>[];

    porPessoa.forEach((pessoaId, avaliacoes) {
      final pessoa = _buscarPessoa(pessoas, pessoaId);
      if (pessoa == null) return;

      final soma = avaliacoes.fold<int>(0, (a, b) => a + b.pontuacaoTotal);
      final media = soma / avaliacoes.length;

      entries.add(RankingEntry(
        pessoa: pessoa,
        pontuacao: media,
        quantidadeAvaliacoes: avaliacoes.length,
      ));
    });

    entries.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));
    return entries;
  }
}