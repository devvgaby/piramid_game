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
      'criadoPorUid': student.criadoPorUid,
      'criadoPorEmail': student.criadoPorEmail,
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
      criadoPorUid: map['criadoPorUid'] as String?,
      criadoPorEmail: map['criadoPorEmail'] as String?,
    );
  }
}