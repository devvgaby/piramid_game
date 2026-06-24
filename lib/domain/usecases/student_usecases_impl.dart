import '../../core/typedefs/type_defs.dart';
import '../../data/repositories/student_repository_interface.dart';
import 'student_usecases_interface.dart';


final class GetStudentByIdUseCaseImpl implements IGetStudentByIdUseCase {
  final IStudentRepository _repository;

  GetStudentByIdUseCaseImpl({
    required IStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<StudentResult> call(StudentIdParams params) {
    return _repository.getStudentById(params.id);
  }
}

final class GetAllStudentsUseCaseImpl implements IGetAllStudentsUseCase {
  final IStudentRepository _repository;

  GetAllStudentsUseCaseImpl({
    required IStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<ListStudentResult> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 3));

    return _repository.getAllStudents();
  }
}

final class SaveStudentUseCaseImpl implements ISaveStudentUseCase {
  final IStudentRepository _repository;

  SaveStudentUseCaseImpl({
    required IStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<StudentResult> call(StudentParams params) async {
    await Future.delayed(const Duration(seconds: 3));

    return _repository.saveStudent(params.student);
  }
}

final class DeleteStudentUseCaseImpl implements IDeleteStudentUseCase {
  final IStudentRepository _repository;

  DeleteStudentUseCaseImpl({
    required IStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<StudentResult> call(StudentIdParams params) {
    return _repository.deleteStudent(params.id);
  }
}

final class UpdateStudentUseCaseImpl implements IUpdateStudentUseCase {
  final IStudentRepository _repository;

  UpdateStudentUseCaseImpl({
    required IStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<StudentResult> call(StudentParams params) {
    return _repository.updateStudent(params.student);
  }
}