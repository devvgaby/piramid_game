import 'package:signals_flutter/signals_flutter.dart';
import '../../domain/models/student_entity.dart';

class StudentsStateViewModel {
  final state = Signal<List<StudentEntity>>([]);

  final message = signal<String?>(null);

  final successEvent = signal<dynamic>(null);

  void clearMessage() => message.value = null;

  void setMessage(String msg) => message.value = msg;
}