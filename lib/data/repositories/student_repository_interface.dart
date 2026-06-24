import '../../core/typedefs/type_defs.dart';
import '../../domain/models/student_entity.dart';

abstract interface class IStudentRepository {
  Future<StudentResult> saveStudent(StudentEntity student);
  Future<StudentResult> getStudentById(String id);
  Future<ListStudentResult> getAllStudents();
  Future<StudentResult> deleteStudent(String id);
  Future<StudentResult> updateStudent(StudentEntity student);
}