import 'package:dartz/dartz.dart';
import '../../../lib/core/utils/input_coverter.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/error/failures.dart';

void main() {
  late InputConverterImpl inputConverter;
  setUp(() {
    inputConverter = InputConverterImpl();
  });

  test('should return an integert when the integer string is valid', () {
    // Arrange
    const str = '123';
    
    // Act
    final result = inputConverter.stringToUnsignedInteger(str);
    
    // Assert
    expect(result, const Right(123));
  });
  test('should return InvalidInputFailure when the string is a negative integer', () {
    // Arrange
    const str = '-45';
    
    // Act
    final result = inputConverter.stringToUnsignedInteger(str);
    
    // Assert
    expect(result, const Left(InvalidInputFailure()));
  });
}