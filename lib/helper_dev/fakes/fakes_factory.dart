import 'package:faker_dart/faker_dart.dart';
import '../../domain/models/student_entity.dart';

abstract class FakeFactory {
  static final Faker _faker = Faker.instance..setLocale(FakerLocaleType.pt_PT);

  static StudentEntity student() {
    final now = DateTime.now();

    int score() => _faker.datatype.number(min: 1, max: 5);

    return StudentEntity(
      id: _faker.datatype.uuid(),
      name: _faker.name.fullName(),
      course: StudentCourse.values[
          _faker.datatype.number(max: StudentCourse.values.length - 1)],
      classYear: _faker.datatype.number(min: 1998, max: 2026),
      nickname: _faker.name.firstName(),
      birthDate: now.subtract(
        Duration(days: _faker.datatype.number(min: 5000, max: 10000)),
      ),

      resenha: score(),
      presencaVip: score(),
      aura: score(),
      modoParceiro: score(),
      carismaNatural: score(),
      humorMilhoes: score(),
      energiaGrupo: score(),
      criatividadeCaotica: score(),
      modoAtleta: score(),
      talentoPalco: score(),
      dripEscolar: score(),
      coracaoDorama: score(),
      queridinhoProfessores: score(),
      cerebroTurbo: score(),
      caosControlado: score(),
    );
  }
}