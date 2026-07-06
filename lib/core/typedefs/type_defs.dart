import 'package:flutter/material.dart';

import '../../domain/models/student_entity.dart';
import '../failure/failure.dart';
import '../patterns/result.dart';

typedef VoidResult = Result<void, Failure>;

typedef StudentResult = Result<StudentEntity, Failure>;

typedef ListStudentResult = Result<List<StudentEntity>, Failure>;

typedef NoParams = ();

typedef StudentParams = ({
  StudentEntity student,
});

typedef StudentIdParams = ({
  String id,
});

typedef FormFieldControl = ({
  GlobalKey<FormFieldState> key,
  FocusNode focus,
  TextEditingController controller,
});