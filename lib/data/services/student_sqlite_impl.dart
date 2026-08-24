import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/models/student_entity.dart';
import '../../domain/models/student_mapper.dart';
import 'database/app_database.dart';
import 'student_local_storage_interface.dart';

final class StudentSqliteService implements IStudentLocalStorage {
  final AppDatabase _appDatabase;

  StudentSqliteService({AppDatabase? appDatabase})
      : _appDatabase = appDatabase ?? AppDatabase.instance;

  @override
  Future<StudentResult> saveStudent(StudentEntity student) async {
    try {
      final db = await _appDatabase.database;

      await db.insert(
        AppDatabase.studentsTable,
        StudentMapper.toMap(student),
      );

      return Success(student);
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
      final db = await _appDatabase.database;

      final rows = await db.query(AppDatabase.studentsTable);

      if (rows.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final students = rows.map(StudentMapper.fromMap).toList();

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
    try {
      final db = await _appDatabase.database;

      final rows = await db.query(
        AppDatabase.studentsTable,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (rows.isEmpty) {
        return Error(
          ApiLocalFailure(
            'Aluno não encontrado',
          ),
        );
      }

      return Success(StudentMapper.fromMap(rows.first));
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao obter aluno: $e',
        ),
      );
    }
  }

  @override
  Future<StudentResult> deleteStudent(String id) async {
    try {
      final db = await _appDatabase.database;

      final rows = await db.query(
        AppDatabase.studentsTable,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (rows.isEmpty) {
        return Error(
          ApiLocalFailure(
            'Aluno não encontrado',
          ),
        );
      }

      final student = StudentMapper.fromMap(rows.first);

      await db.delete(
        AppDatabase.studentsTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      return Success(student);
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
      final db = await _appDatabase.database;

      final count = await db.update(
        AppDatabase.studentsTable,
        StudentMapper.toMap(student),
        where: 'id = ?',
        whereArgs: [student.id],
      );

      if (count == 0) {
        return Error(
          ApiLocalFailure(
            'Aluno não encontrado para atualização',
          ),
        );
      }

      return Success(student);
    } catch (e) {
      return Error(
        ApiLocalFailure(
          'Erro ao atualizar aluno: $e',
        ),
      );
    }
  }
}
