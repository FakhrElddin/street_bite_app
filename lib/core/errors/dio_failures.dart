import 'package:dio/dio.dart';
import 'package:street_bite_app/core/errors/failures.dart';

class ServerFailure extends Failures {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: "Connection timeout with API server",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: "Send timeout in connection with API server",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: "Receive timeout in connection with API server",
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: "Request to API server was cancelled",
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage: "No Internet Connection or Server Refused",
        );
      default:
        return ServerFailure(
          errorMessage: "Something went wrong, please try again",
        );
    }
  }
}

class NetworkFailure extends Failures {
  NetworkFailure({
    super.errorMessage = 'No Internet Connection, Please Check Your Network',
  });
}
