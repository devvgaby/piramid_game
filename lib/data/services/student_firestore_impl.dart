import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/type_defs.dart';
import '../../domain/models/student_entity.dart';
import '../../domain/models/student_mapper.dart';
import 'student_local_storage_interface.dart';

final class StudentFirestoreService implements IStudentLocalStorage {
  final FirebaseFirestore _db;
  static const String _collection = 'pessoas';

  StudentFirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  @override
  Future<StudentResult> saveStudent(StudentEntity student) async {
    try {
      await _db.collection(_collection).doc(student.id).set(
            StudentMapper.toMap(student),
          );
      return Success(student);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao salvar aluno: $e'));
    }
  }

  @override
  Future<ListStudentResult> getAllStudents() async {
    try {
      final snapshot = await _db.collection(_collection).get();

      if (snapshot.docs.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final students = snapshot.docs
          .map((doc) => StudentMapper.fromMap(doc.data()))
          .toList();

      return Success(students);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao obter alunos: $e'));
    }
  }

  @override
  Future<StudentResult> getStudentById(String id) async {
    try {
      final doc = await _db.collection(_collection).doc(id).get();

      if (!doc.exists) {
        return Error(ApiLocalFailure('Aluno não encontrado'));
      }

      return Success(StudentMapper.fromMap(doc.data()!));
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao buscar aluno: $e'));
    }
  }

  @override
  Future<StudentResult> deleteStudent(String id) async {
    try {
      final current = await getStudentById(id);

      return await current.fold(
        onSuccess: (student) async {
          await _db.collection(_collection).doc(id).delete();
          return Success(student);
        },
        onFailure: (failure) async => Error(failure),
      );
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao remover aluno: $e'));
    }
  }

  @override
  Future<StudentResult> updateStudent(StudentEntity student) async {
    try {
      await _db.collection(_collection).doc(student.id).update(
            StudentMapper.toMap(student),
          );
      return Success(student);
    } catch (e) {
      return Error(ApiLocalFailure('Erro ao atualizar aluno: $e'));
    }
  }
}