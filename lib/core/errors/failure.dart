import 'package:dio/dio.dart';

abstract class Failure {
  final String errMesage;

  const Failure({required this.errMesage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMesage});
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMesage: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMesage: 'Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMesage: 'Receive timeout with API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errMesage: 'Request was Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(errMesage: 'Connection error');

      case DioExceptionType.unknown:
        return ServerFailure(errMesage: 'No internet connection');

      case DioExceptionType.badCertificate:
        return ServerFailure(errMesage: 'Bad certificate');
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 403) {
      return ServerFailure(errMesage: response['message']);
    } else if (statusCode == 401) {
      return ServerFailure(
          errMesage: 'Your email address or password is wrong !');
    } else if (statusCode == 404) {
      return ServerFailure(errMesage: 'Your request not found !');
    } else if (statusCode == 500) {
      return ServerFailure(
        errMesage: ' Something went wrong , Tap to try again',
      );
    } else if (statusCode == 422) {
      return ServerFailure(errMesage: response['message']);
    } else {
      return ServerFailure(
        errMesage: 'Oops!! there was an error , Tap to try again',
      );
    }
  }
}
