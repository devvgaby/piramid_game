import '../../core/typedefs/type_defs.dart';
import '../usecases/student_usecases_interface.dart';
import 'student_facade_interface.dart';


final class StudentFacadeUseCasesImpl
    implements IStudentFacadeUseCases {
  final IGetAllStudentsUseCase _getAllStudentsUseCase;
  final IGetStudentByIdUseCase _getStudentByIdUseCase;
  final ISaveStudentUseCase _saveStudentUseCase;
  final IDeleteStudentUseCase _deleteStudentUseCase;
  final IUpdateStudentUseCase _updateStudentUseCase;

  StudentFacadeUseCasesImpl({
    required IGetAllStudentsUseCase getAllStudentsUseCase,
    required IGetStudentByIdUseCase getStudentByIdUseCase,
    required ISaveStudentUseCase saveStudentUseCase,
    required IDeleteStudentUseCase deleteStudentUseCase,
    required IUpdateStudentUseCase updateStudentUseCase,
  }) : _getAllStudentsUseCase = getAllStudentsUseCase,
       _getStudentByIdUseCase = getStudentByIdUseCase,
       _saveStudentUseCase = saveStudentUseCase,
       _deleteStudentUseCase = deleteStudentUseCase,
       _updateStudentUseCase = updateStudentUseCase;

  @override
  Future<ListStudentResult> getAllStudents(
    NoParams params,
  ) {
    return _getAllStudentsUseCase(params);
  }

  @override
  Future<StudentResult> getStudentById(
    StudentIdParams params,
  ) {
    return _getStudentByIdUseCase(params);
  }

  @override
  Future<StudentResult> saveStudent(
    StudentParams params,
  ) {
    return _saveStudentUseCase(params);
  }

  @override
  Future<StudentResult> deleteStudent(
    StudentIdParams params,
  ) {
    return _deleteStudentUseCase(params);
  }

  @override
  Future<StudentResult> updateStudent(
    StudentParams params,
  ) {
    return _updateStudentUseCase(params);
  }
}