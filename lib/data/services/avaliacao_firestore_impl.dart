import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/models/avaliacao_entity.dart';
import '../../domain/models/avaliacao_mapper.dart';

final class AvaliacaoFirestoreService {
  final FirebaseFirestore _db;
  static const String _collection = 'avaliacoes';

  AvaliacaoFirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  String _docId(String avaliadorUid, String pessoaId) =>
      '${avaliadorUid}_$pessoaId';

  Future<AvaliacaoResult> salvarAvaliacao(AvaliacaoEntity avaliacao) async {
    try {
      if (avaliacao.avaliadorUid == avaliacao.pessoaId) {
        return Error(SelfEvaluationFailure());
      }

      avaliacao.validate();

      final docId = _docId(avaliacao.avaliadorUid, avaliacao.pessoaId);
      await _db.collection(_collection).doc(docId).set(
            AvaliacaoMapper.toMap(avaliacao),
          );

      return Success(avaliacao);
    } on ArgumentError catch (e) {
      return Error(InputFailure(e.message.toString()));
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao salvar avaliação: $e'));
    }
  }

  Future<AvaliacaoResult?> buscarAvaliacaoExistente({
    required String avaliadorUid,
    required String pessoaId,
  }) async {
    try {
      final docId = _docId(avaliadorUid, pessoaId);
      final doc = await _db.collection(_collection).doc(docId).get();

      if (!doc.exists) return null;

      return Success(AvaliacaoMapper.fromMap(doc.data()!));
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao buscar avaliação: $e'));
    }
  }

  Future<ListAvaliacaoResult> buscarAvaliacoesPorAvaliador(
      String avaliadorUid) async {
    try {
      final snapshot = await _db
          .collection(_collection)
          .where('avaliadorUid', isEqualTo: avaliadorUid)
          .get();

      final avaliacoes = snapshot.docs
          .map((doc) => AvaliacaoMapper.fromMap(doc.data()))
          .toList();

      return Success(avaliacoes);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao buscar avaliações: $e'));
    }
  }

  Future<ListAvaliacaoResult> buscarAvaliacoesPorPessoa(
      String pessoaId) async {
    try {
      final snapshot = await _db
          .collection(_collection)
          .where('pessoaId', isEqualTo: pessoaId)
          .get();

      final avaliacoes = snapshot.docs
          .map((doc) => AvaliacaoMapper.fromMap(doc.data()))
          .toList();

      return Success(avaliacoes);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao buscar avaliações da pessoa: $e'));
    }
  }

  Future<ListAvaliacaoResult> buscarTodasAvaliacoes() async {
    try {
      final snapshot = await _db.collection(_collection).get();

      final avaliacoes = snapshot.docs
          .map((doc) => AvaliacaoMapper.fromMap(doc.data()))
          .toList();

      return Success(avaliacoes);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao buscar avaliações: $e'));
    }
  }
}