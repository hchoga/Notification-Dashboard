import 'package:dartz/dartz.dart';

import 'failure.dart';

/// Base class for all use cases following Single Responsibility Principle
/// Generic parameters: Params - input parameters, ReturnType - return type
abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

/// For use cases that don't take any parameters
class NoParams {
  const NoParams();
}
