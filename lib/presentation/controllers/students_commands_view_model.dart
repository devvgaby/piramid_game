import 'package:signals_flutter/signals_flutter.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../domain/models/student_entity.dart';

import '../commands/student_commands.dart';
import 'students_state_viewmodel.dart';

class StudentCommandsViewModel {
  final StudentsStateViewModel state;

  final GetAllStudentsCommand _getAllStudentsCommand;
  final GetStudentByIdCommand _getStudentByIdCommand;
  final SaveStudentCommand _saveStudentCommand;
  final DeleteStudentCommand _deleteStudentCommand;
  final UpdateStudentCommand _updateStudentCommand;

  StudentCommandsViewModel({
    required this.state,
    required GetAllStudentsCommand getAllStudentsCommand,
    required GetStudentByIdCommand getStudentByIdCommand,
    required SaveStudentCommand saveStudentCommand,
    required DeleteStudentCommand deleteStudentCommand,
    required UpdateStudentCommand updateStudentCommand,
  })  : _getAllStudentsCommand = getAllStudentsCommand,
        _getStudentByIdCommand = getStudentByIdCommand,
        _saveStudentCommand = saveStudentCommand,
        _deleteStudentCommand = deleteStudentCommand,
        _updateStudentCommand = updateStudentCommand {
    _observeGetAllStudents();
    _observeGetStudentById();
    _observeSaveStudent();
    _observeDeleteStudent();
    _observeUpdateStudent();
  }

  GetAllStudentsCommand get getAllStudentsCommand =>
      _getAllStudentsCommand;

  GetStudentByIdCommand get getStudentByIdCommand =>
      _getStudentByIdCommand;

  SaveStudentCommand get saveStudentCommand =>
      _saveStudentCommand;

  DeleteStudentCommand get deleteStudentCommand =>
      _deleteStudentCommand;

  UpdateStudentCommand get updateStudentCommand =>
      _updateStudentCommand;

  void _observeCommand<T>(
    Command<T, Failure> command, {
    required void Function(T data) onSuccess,
  }) {
    effect(() {
      if (command.isExecuting.value) return;

      final result = command.result.value;

      if (result == null) return;

      result.fold(
        onSuccess: (data) {
          state.clearMessage();
          onSuccess(data);
          command.clear();
        },
        onFailure: (failure) {
          state.setMessage(failure.msg);
          command.clear();
        },
      );
    });
  }

  void _observeGetAllStudents() {
    _observeCommand<List<StudentEntity>>(
      _getAllStudentsCommand,
      onSuccess: (students) {
        state.state.value = students;
      },
    );
  }

  void _observeSaveStudent() {
    _observeCommand<StudentEntity>(
      _saveStudentCommand,
      onSuccess: (student) {
        state.state.value = [
          ...state.state.value,
          student,
        ];
      },
    );
  }

  void _observeDeleteStudent() {
    _observeCommand<StudentEntity>(
      _deleteStudentCommand,
      onSuccess: (student) {
        state.state.value = state.state.value
            .where((s) => s.id != student.id)
            .toList();
      },
    );
  }

  void _observeUpdateStudent() {
    _observeCommand<StudentEntity>(
      _updateStudentCommand,
      onSuccess: (updatedStudent) {
        state.state.value = state.state.value.map((student) {
          return student.id == updatedStudent.id
              ? updatedStudent
              : student;
        }).toList();
      },
    );
  }

  void _observeGetStudentById() {
    _observeCommand<StudentEntity>(
      _getStudentByIdCommand,
      onSuccess: (_) {},
    );
  }

  Future<void> fetchStudents() async =>
      await _getAllStudentsCommand.executeWith(());

  Future<void> saveStudent(StudentEntity student) async =>
      await _saveStudentCommand.executeWith(
        (student: student),
      );

  Future<void> getStudentById(String id) async =>
      await _getStudentByIdCommand.executeWith(
        (id: id),
      );

  Future<void> deleteStudent(String id) async =>
      await _deleteStudentCommand.executeWith(
        (id: id),
      );

  Future<void> updateStudent(StudentEntity student) async =>
      await _updateStudentCommand.executeWith(
        (student: student),
      );
}