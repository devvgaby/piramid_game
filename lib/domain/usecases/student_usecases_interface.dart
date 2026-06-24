import '../../core/patterns/i_usecases.dart';
import '../../core/typedefs/type_defs.dart';

abstract interface class IGetStudentByIdUseCase
    implements IUseCase<StudentResult, StudentIdParams> {}

abstract interface class IGetAllStudentsUseCase
    implements IUseCase<ListStudentResult, NoParams> {}

abstract interface class ISaveStudentUseCase
    implements IUseCase<StudentResult, StudentParams> {}

abstract interface class IDeleteStudentUseCase
    implements IUseCase<StudentResult, StudentIdParams> {}

abstract interface class IUpdateStudentUseCase
    implements IUseCase<StudentResult, StudentParams> {}