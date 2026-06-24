import 'student_entity.dart';

class StudentMapper {
  static Map<String, dynamic> toMap(StudentEntity student) {
    return {
      'id': student.id,
      'name': student.name,
      'course': student.course.name,
      'classYear': student.classYear,
      'nickname': student.nickname,
      'birthDate': student.birthDate.toIso8601String(),
      'resenha': student.resenha,
      'presencaVip': student.presencaVip,
      'aura': student.aura,
      'modoParceiro': student.modoParceiro,
      'carismaNatural': student.carismaNatural,
      'humorMilhoes': student.humorMilhoes,
      'energiaGrupo': student.energiaGrupo,
      'criatividadeCaotica': student.criatividadeCaotica,
      'modoAtleta': student.modoAtleta,
      'talentoPalco': student.talentoPalco,
      'dripEscolar': student.dripEscolar,
      'coracaoDorama': student.coracaoDorama,
      'queridinhoProfessores': student.queridinhoProfessores,
      'cerebroTurbo': student.cerebroTurbo,
      'caosControlado': student.caosControlado,
    };
  }

  static StudentEntity fromMap(Map<String, dynamic> map) {
    return StudentEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      course: StudentCourse.values.byName(map['course'] as String),
      classYear: map['classYear'] as int,
      nickname: map['nickname'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
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
