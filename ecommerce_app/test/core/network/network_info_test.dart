import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../features/product/data/repositories/product_repositories_impl_test.mocks.dart';



void main(){
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
    });
    test('test description', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      // Act
      final result = await mockNetworkInfo.isConnected;
  
      // Assert
      expect(result, true);
    });
}