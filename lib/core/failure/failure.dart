import '../messages/app_messages.dart';

sealed class Failure implements Exception {
  final String msg;

  Failure(this.msg);

  @override
  String toString() => '$runtimeType: $msg!!!';
}

class DefaultFailure extends Failure {
  DefaultFailure([String? msg])
      : super(msg ?? AppMessages.error.defaultError);
}

class ApiLocalFailure extends Failure {
  ApiLocalFailure([String? msg])
      : super(msg ?? AppMessages.error.apiLocalError);
}

class EmptyResultFailure extends Failure {
  EmptyResultFailure([String? msg])
      : super(msg ?? AppMessages.error.emptyResultError);
}

class InputFailure extends Failure {
  InputFailure([String? msg])
      : super(msg ?? AppMessages.error.invalidNameError);
}

class InvalidStudentNameFailure extends Failure {
  InvalidStudentNameFailure([String? msg])
      : super(msg ?? AppMessages.error.invalidNameError);
}

class InvalidClassYearFailure extends Failure {
  InvalidClassYearFailure([String? msg])
      : super(msg ?? AppMessages.error.invalidClassYearError);
}

class InvalidScoreFailure extends Failure {
  InvalidScoreFailure([String? msg])
      : super(msg ?? AppMessages.error.invalidScoreError);
}