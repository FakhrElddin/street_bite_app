abstract class Failures {
  final String errorMessage;

  Failures({required this.errorMessage});
}

class UnexpectedFailure extends Failures {
  UnexpectedFailure({required super.errorMessage});
}
