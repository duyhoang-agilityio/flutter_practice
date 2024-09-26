abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class OperationCanceledFailure extends Failure {
  const OperationCanceledFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
