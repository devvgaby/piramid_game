import 'package:equatable/equatable.dart';

class AvaliacaoEntity extends Equatable {
  final String id;
  final String avaliadorUid;
  final String pessoaId;
  final DateTime dataAvaliacao;

  final int resenha;
  final int presencaVip;
  final int aura;
  final int modoParceiro;
  final int carismaNatural;
  final int humorMilhoes;
  final int energiaGrupo;
  final int criatividadeCaotica;
  final int modoAtleta;
  final int talentoPalco;
  final int dripEscolar;
  final int coracaoDorama;
  final int queridinhoProfessores;
  final int cerebroTurbo;
  final int caosControlado;

  const AvaliacaoEntity({
    required this.id,
    required this.avaliadorUid,
    required this.pessoaId,
    required this.dataAvaliacao,
    required this.resenha,
    required this.presencaVip,
    required this.aura,
    required this.modoParceiro,
    required this.carismaNatural,
    required this.humorMilhoes,
    required this.energiaGrupo,
    required this.criatividadeCaotica,
    required this.modoAtleta,
    required this.talentoPalco,
    required this.dripEscolar,
    required this.coracaoDorama,
    required this.queridinhoProfessores,
    required this.cerebroTurbo,
    required this.caosControlado,
  });

  int get pontuacaoTotal =>
      resenha +
      presencaVip +
      aura +
      modoParceiro +
      carismaNatural +
      humorMilhoes +
      energiaGrupo +
      criatividadeCaotica +
      modoAtleta +
      talentoPalco +
      dripEscolar +
      coracaoDorama +
      queridinhoProfessores +
      cerebroTurbo +
      caosControlado;

  void validate() {
    if (avaliadorUid == pessoaId) {
      throw ArgumentError('Autoavaliação não é permitida');
    }

    final notas = [
      resenha, presencaVip, aura, modoParceiro, carismaNatural,
      humorMilhoes, energiaGrupo, criatividadeCaotica, modoAtleta,
      talentoPalco, dripEscolar, coracaoDorama, queridinhoProfessores,
      cerebroTurbo, caosControlado,
    ];

    for (final nota in notas) {
      if (nota < 1 || nota > 5) {
        throw ArgumentError('Todas as notas devem estar entre 1 e 5');
      }
    }
  }

  AvaliacaoEntity copyWith({
    int? resenha,
    int? presencaVip,
    int? aura,
    int? modoParceiro,
    int? carismaNatural,
    int? humorMilhoes,
    int? energiaGrupo,
    int? criatividadeCaotica,
    int? modoAtleta,
    int? talentoPalco,
    int? dripEscolar,
    int? coracaoDorama,
    int? queridinhoProfessores,
    int? cerebroTurbo,
    int? caosControlado,
    DateTime? dataAvaliacao,
  }) {
    return AvaliacaoEntity(
      id: id,
      avaliadorUid: avaliadorUid,
      pessoaId: pessoaId,
      dataAvaliacao: dataAvaliacao ?? this.dataAvaliacao,
      resenha: resenha ?? this.resenha,
      presencaVip: presencaVip ?? this.presencaVip,
      aura: aura ?? this.aura,
      modoParceiro: modoParceiro ?? this.modoParceiro,
      carismaNatural: carismaNatural ?? this.carismaNatural,
      humorMilhoes: humorMilhoes ?? this.humorMilhoes,
      energiaGrupo: energiaGrupo ?? this.energiaGrupo,
      criatividadeCaotica: criatividadeCaotica ?? this.criatividadeCaotica,
      modoAtleta: modoAtleta ?? this.modoAtleta,
      talentoPalco: talentoPalco ?? this.talentoPalco,
      dripEscolar: dripEscolar ?? this.dripEscolar,
      coracaoDorama: coracaoDorama ?? this.coracaoDorama,
      queridinhoProfessores: queridinhoProfessores ?? this.queridinhoProfessores,
      cerebroTurbo: cerebroTurbo ?? this.cerebroTurbo,
      caosControlado: caosControlado ?? this.caosControlado,
    );
  }

  @override
  List<Object?> get props => [
        id, avaliadorUid, pessoaId, dataAvaliacao,
        resenha, presencaVip, aura, modoParceiro, carismaNatural,
        humorMilhoes, energiaGrupo, criatividadeCaotica, modoAtleta,
        talentoPalco, dripEscolar, coracaoDorama, queridinhoProfessores,
        cerebroTurbo, caosControlado,
      ];
}