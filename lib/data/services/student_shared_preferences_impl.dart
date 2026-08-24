import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/models/student_entity.dart';
import '../../domain/models/student_mapper.dart';
import 'student_local_storage_interface.dart';

final class StudentSharedPreferencesService
    implements IStudentLocalStorage {
  static const String _storageKey = 'students';

  @override
  Future<StudentResult> saveStudent(StudentEntity student) async {
    try {
      final currentResult = await getAllStudents();

      return await currentResult.fold(
        onSuccess: (students) async {
          final updatedStudents = [...students, student];

          await _saveStudents(updatedStudents);

          return Success(student);
        },
        onFailure: (failure) async {
          if (failure is EmptyResultFailure) {
            await _saveStudents([student]);

            return Success(student);
          }

          return Error(ApiLocalFailure());
        },
      );
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao salvar aluno: $e',
        ),
      );
    }
  }

  @override
  Future<ListStudentResult> getAllStudents() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final result = prefs.getString(_storageKey);

      if (result == null || result.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final decoded = jsonDecode(result) as List<dynamic>;

      final students = decoded
          .map(
            (e) => StudentMapper.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      return Success(students);
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao obter alunos: $e',
        ),
      );
    }
  }

  @override
  Future<StudentResult> getStudentById(String id) async {
    final result = await getAllStudents();

    return result.fold(
      onSuccess: (students) {
        try {
          final student = students.firstWhere(
            (student) => student.id == id,
          );

          return Success(student);
        } catch (e) {
          return Error(
            ApiLocalFailure(
              'Aluno não encontrado',
            ),
          );
        }
      },
      onFailure: (failure) => Error(failure),
    );
  }

  @override
  Future<StudentResult> deleteStudent(String id) async {
    try {
      final currentResult = await getAllStudents();

      return await currentResult.fold(
        onSuccess: (students) async {
          final updatedStudents = students
              .where(
                (student) => student.id != id,
              )
              .toList();

          await _saveStudents(updatedStudents);

          return Success(
            students.firstWhere(
              (student) => student.id == id,
            ),
          );
        },
        onFailure: (failure) => Error(failure),
      );
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao remover aluno: $e',
        ),
      );
    }
  }

  @override
  Future<StudentResult> updateStudent(StudentEntity student) async {
    try {
      final currentResult = await getAllStudents();

      return await currentResult.fold(
        onSuccess: (students) async {
          final index = students.indexWhere(
            (s) => s.id == student.id,
          );

          if (index == -1) {
            return Error(
              ApiLocalFailure(
                'Aluno não encontrado para atualização',
              ),
            );
          }

          students[index] = student;

          await _saveStudents(students);

          return Success(student);
        },
        onFailure: (failure) => Error(failure),
      );
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao atualizar aluno: $e',
        ),
      );
    }
  }

  Future<void> _saveStudents(
    List<StudentEntity> students,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jsonString = jsonEncode(
        students
            .map(StudentMapper.toMap)
            .toList(),
      );

      await prefs.setString(
        _storageKey,
        jsonString,
      );
    } catch (e) {
      throw ApiLocalFailure(
        'Erro ao salvar alunos: $e',
      );
    }
  }
}