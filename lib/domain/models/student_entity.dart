import 'package:equatable/equatable.dart';

enum StudentCourse {
  INFO,
  MEC,
  MAMB,
  PROD,
  TADS,
  TGA;

  String get displayName {
    switch (this) {
      case StudentCourse.INFO:
        return 'INFO';
      case StudentCourse.MEC:
        return 'MEC';
      case StudentCourse.MAMB:
        return 'MAMB';
      case StudentCourse.PROD:
        return 'PROD';
      case StudentCourse.TADS:
        return 'TADS';
      case StudentCourse.TGA:
        return 'TGA';
    }
  }
}

class StudentEntity extends Equatable {
  final String id;

  final String name;
  final StudentCourse course;
  final int classYear;
  final String nickname;
  final DateTime birthDate;

  final String? criadoPorUid;
  final String? criadoPorEmail;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.course,
    required this.classYear,
    required this.nickname,
    required this.birthDate,
    this.criadoPorUid,
    this.criadoPorEmail,
  });

  void validate() {
    if (name.trim().isEmpty) {
      throw ArgumentError('Nome é obrigatório');
    }

    if (classYear < 1998 || classYear > 2026) {
      throw ArgumentError('Turma deve estar entre 1998 e 2026');
    }
  }

  StudentEntity copyWith({
    String? id,
    String? name,
    StudentCourse? course,
    int? classYear,
    String? nickname,
    DateTime? birthDate,
    String? criadoPorUid,
    String? criadoPorEmail,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      course: course ?? this.course,
      classYear: classYear ?? this.classYear,
      nickname: nickname ?? this.nickname,
      birthDate: birthDate ?? this.birthDate,
      criadoPorUid: criadoPorUid ?? this.criadoPorUid,
      criadoPorEmail: criadoPorEmail ?? this.criadoPorEmail,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        course,
        classYear,
        nickname,
        birthDate,
        criadoPorUid,
        criadoPorEmail,
      ];

  @override
  String toString() {
    return 'StudentEntity('
        'id: $id, '
        'name: $name, '
        'course: ${course.name}, '
        'classYear: $classYear, '
        'nickname: $nickname, '
        'criadoPorEmail: $criadoPorEmail'
        ')';
  }
}