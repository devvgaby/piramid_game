import '../../domain/facades/student_facade_interface.dart';
import '../commands/student_commands.dart';
import 'students_commands_view_model.dart';
import 'students_state_viewmodel.dart';

class StudentsViewModel {
  late final StudentsStateViewModel _state;

  StudentsStateViewModel get studentsState => _state;

  late final StudentCommandsViewModel commands;

  StudentsViewModel(IStudentFacadeUseCases facade) {
    _state = StudentsStateViewModel();

    commands = StudentCommandsViewModel(
      state: _state,
      getAllStudentsCommand: GetAllStudentsCommand(facade),
      getStudentByIdCommand: GetStudentByIdCommand(facade),
      saveStudentCommand: SaveStudentCommand(facade),
      deleteStudentCommand: DeleteStudentCommand(facade),
      updateStudentCommand: UpdateStudentCommand(facade),
    );
  }

  GetAllStudentsCommand get getAllStudentsCommand =>
      commands.getAllStudentsCommand;

  GetStudentByIdCommand get getStudentByIdCommand =>
      commands.getStudentByIdCommand;

  SaveStudentCommand get saveStudentCommand =>
      commands.saveStudentCommand;

  DeleteStudentCommand get deleteStudentCommand =>
      commands.deleteStudentCommand;

  UpdateStudentCommand get updateStudentCommand =>
      commands.updateStudentCommand;
}