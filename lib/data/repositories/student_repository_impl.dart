import '../../core/typedefs/type_defs.dart';
import '../../domain/models/student_entity.dart';
import '../services/student_local_storage_interface.dart';
import 'student_repository_interface.dart';


final class StudentRepositoryImpl implements IStudentRepository {
  final IStudentLocalStorage _localStorage;

  StudentRepositoryImpl({
    required IStudentLocalStorage localStorage,
  }) : _localStorage = localStorage;

  @override
  Future<StudentResult> deleteStudent(String id) {
    return _localStorage.deleteStudent(id);
  }

  @override
  Future<StudentResult> getStudentById(String id) {
    return _localStorage.getStudentById(id);
  }

  @override
  Future<ListStudentResult> getAllStudents() {
    return _localStorage.getAllStudents();
  }

  @override
  Future<StudentResult> saveStudent(StudentEntity student) {
    return _localStorage.saveStudent(student);
  }

  @override
  Future<StudentResult> updateStudent(StudentEntity student) {
    return _localStorage.updateStudent(student);
  }
}