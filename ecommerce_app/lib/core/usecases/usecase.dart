import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NoParams;

  @override
  int get hashCode => 0;
}

class DeleteProductParams {
  final String productId;

  DeleteProductParams(this.productId);
}