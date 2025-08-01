import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str);
}

class InputConverterImpl implements InputConverter {
  @override
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) {
        return const Left(InvalidInputFailure());
      }
      return Right(integer);
    } catch (_) {
      return const Left(InvalidInputFailure());
    }
  }
}