import 'avaliacao_entity.dart';

class AvaliacaoMapper {
  static Map<String, dynamic> toMap(AvaliacaoEntity avaliacao) {
    return {
      'id': avaliacao.id,
      'avaliadorUid': avaliacao.avaliadorUid,
      'pessoaId': avaliacao.pessoaId,
      'dataAvaliacao': avaliacao.dataAvaliacao.toIso8601String(),
      'resenha': avaliacao.resenha,
      'presencaVip': avaliacao.presencaVip,
      'aura': avaliacao.aura,
      'modoParceiro': avaliacao.modoParceiro,
      'carismaNatural': avaliacao.carismaNatural,
      'humorMilhoes': avaliacao.humorMilhoes,
      'energiaGrupo': avaliacao.energiaGrupo,
      'criatividadeCaotica': avaliacao.criatividadeCaotica,
      'modoAtleta': avaliacao.modoAtleta,
      'talentoPalco': avaliacao.talentoPalco,
      'dripEscolar': avaliacao.dripEscolar,
      'coracaoDorama': avaliacao.coracaoDorama,
      'queridinhoProfessores': avaliacao.queridinhoProfessores,
      'cerebroTurbo': avaliacao.cerebroTurbo,
      'caosControlado': avaliacao.caosControlado,
    };
  }

  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      id: map['id'] as String,
      avaliadorUid: map['avaliadorUid'] as String,
      pessoaId: map['pessoaId'] as String,
      dataAvaliacao: DateTime.parse(map['dataAvaliacao'] as String),
      resenha: map['resenha'] as int,
      presencaVip: map['presencaVip'] as int,
      aura: map['aura'] as int,
      modoParceiro: map['modoParceiro'] as int,
      carismaNatural: map['carismaNatural'] as int,
      humorMilhoes: map['humorMilhoes'] as int,
      energiaGrupo: map['energiaGrupo'] as int,
      criatividadeCaotica: map['criatividadeCaotica'] as int,
      modoAtleta: map['modoAtleta'] as int,
      talentoPalco: map['talentoPalco'] as int,
      dripEscolar: map['dripEscolar'] as int,
      coracaoDorama: map['coracaoDorama'] as int,
      queridinhoProfessores: map['queridinhoProfessores'] as int,
      cerebroTurbo: map['cerebroTurbo'] as int,
      caosControlado: map['caosControlado'] as int,
    );
  }
}