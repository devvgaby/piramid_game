import '../../core/typedefs/type_defs.dart';

abstract interface class IStudentFacadeUseCases {
  Future<ListStudentResult> getAllStudents(NoParams params);
  Future<StudentResult> getStudentById(StudentIdParams params);
  Future<StudentResult> saveStudent(StudentParams params);
  Future<StudentResult> deleteStudent(StudentIdParams params);
  Future<StudentResult> updateStudent(StudentParams params);
}