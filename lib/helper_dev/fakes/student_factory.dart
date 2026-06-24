import '../../domain/models/student_entity.dart';
import 'fakes_factory.dart';

class StudentFactory {
  static StudentEntity single() {
    return FakeFactory.student();
  }

  static List<StudentEntity> list([int count = 5]) {
    return List.generate(count, (_) => single());
  }
}