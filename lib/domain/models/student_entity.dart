import 'package:equatable/equatable.dart';

enum StudentCourse {
  INFO,
  MEC,
  MAMB,
  PROD,
  TADS,
  TGA;

  String get displayName {
    switch (this) {
      case StudentCourse.INFO:
        return 'INFO';
      case StudentCourse.MEC:
        return 'MEC';
      case StudentCourse.MAMB:
        return 'MAMB';
      case StudentCourse.PROD:
        return 'PROD';
      case StudentCourse.TADS:
        return 'TADS';
      case StudentCourse.TGA:
        return 'TGA';
    }
  }
}

class StudentEntity extends Equatable {
  final String id;

  final String name;
  final StudentCourse course;
  final int classYear;
  final String nickname;
  final DateTime birthDate;

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

  const StudentEntity({
    required this.id,
    required this.name,
    required this.course,
    required this.classYear,
    required this.nickname,
    required this.birthDate,
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

  int get legendLevel =>
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

  String get levelName {
  if (legendLevel <= 24) return 'Mortal';
  if (legendLevel <= 34) return 'Guerreiro';
  if (legendLevel <= 44) return 'Elite';
  if (legendLevel <= 54) return 'Mestre';
  if (legendLevel <= 64) return 'Lenda';
  if (legendLevel <= 70) return 'Aura';

  return 'Chaos';
}
  void validate() {
    if (name.trim().isEmpty) {
      throw ArgumentError('Nome é obrigatório');
    }

    if (classYear < 1998 || classYear > 2026) {
      throw ArgumentError('Turma deve estar entre 1998 e 2026');
    }

    final scores = [
      resenha,
      presencaVip,
      aura,
      modoParceiro,
      carismaNatural,
      humorMilhoes,
      energiaGrupo,
      criatividadeCaotica,
      modoAtleta,
      talentoPalco,
      dripEscolar,
      coracaoDorama,
      queridinhoProfessores,
      cerebroTurbo,
      caosControlado,
    ];

    for (final score in scores) {
      if (score < 1 || score > 5) {
        throw ArgumentError(
          'Todos os critérios devem possuir nota entre 1 e 5',
        );
      }
    }
  }

  StudentEntity copyWith({
    String? id,
    String? name,
    StudentCourse? course,
    int? classYear,
    String? nickname,
    DateTime? birthDate,
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
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      course: course ?? this.course,
      classYear: classYear ?? this.classYear,
      nickname: nickname ?? this.nickname,
      birthDate: birthDate ?? this.birthDate,
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
      queridinhoProfessores:
          queridinhoProfessores ?? this.queridinhoProfessores,
      cerebroTurbo: cerebroTurbo ?? this.cerebroTurbo,
      caosControlado: caosControlado ?? this.caosControlado,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        course,
        classYear,
        nickname,
        birthDate,
        resenha,
        presencaVip,
        aura,
        modoParceiro,
        carismaNatural,
        humorMilhoes,
        energiaGrupo,
        criatividadeCaotica,
        modoAtleta,
        talentoPalco,
        dripEscolar,
        coracaoDorama,
        queridinhoProfessores,
        cerebroTurbo,
        caosControlado,
      ];

  @override
  String toString() {
    return 'StudentEntity('
        'id: $id, '
        'name: $name, '
        'course: ${course.name}, '
        'classYear: $classYear, '
        'nickname: $nickname, '
        'legendLevel: $legendLevel'
        ')';
  }
}