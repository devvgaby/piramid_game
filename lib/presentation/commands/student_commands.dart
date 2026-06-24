import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/facades/student_facade_interface.dart';
import '../../domain/models/student_entity.dart';

final class SaveStudentCommand
    extends ParameterizedCommand<StudentEntity, Failure, StudentParams> {

  final IStudentFacadeUseCases _studentFacadeUseCases;

  SaveStudentCommand(this._studentFacadeUseCases);

  @override
  Future<StudentResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para salvar aluno.'));
    }

    return await _studentFacadeUseCases.saveStudent(parameter!);
  }
}

final class DeleteStudentCommand
    extends ParameterizedCommand<StudentEntity, Failure, StudentIdParams> {

  final IStudentFacadeUseCases _studentFacadeUseCases;

  DeleteStudentCommand(this._studentFacadeUseCases);

  @override
  Future<StudentResult> execute() async {
    if (parameter == null || parameter!.id.isEmpty) {
      return Error(InputFailure('Parametro nulo para deletar aluno.'));
    }

    return await _studentFacadeUseCases.deleteStudent(parameter!);
  }
}

final class UpdateStudentCommand
    extends ParameterizedCommand<StudentEntity, Failure, StudentParams> {

  final IStudentFacadeUseCases _studentFacadeUseCases;

  UpdateStudentCommand(this._studentFacadeUseCases);

  @override
  Future<StudentResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para atualizar aluno.'));
    }

    return await _studentFacadeUseCases.updateStudent(parameter!);
  }
}

final class GetAllStudentsCommand
    extends ParameterizedCommand<List<StudentEntity>, Failure, NoParams> {

  final IStudentFacadeUseCases _studentFacadeUseCases;

  GetAllStudentsCommand(this._studentFacadeUseCases);

  @override
  Future<ListStudentResult> execute() async {
    return await _studentFacadeUseCases.getAllStudents(());
  }
}

final class GetStudentByIdCommand
    extends ParameterizedCommand<StudentEntity, Failure, StudentIdParams> {

  final IStudentFacadeUseCases _studentFacadeUseCases;

  GetStudentByIdCommand(this._studentFacadeUseCases);

  @override
  Future<StudentResult> execute() async {
    if (parameter == null || parameter!.id.isEmpty) {
      return Error(InputFailure('Parametro nulo para obter aluno por ID.'));
    }

    return await _studentFacadeUseCases.getStudentById(parameter!);
  }
}