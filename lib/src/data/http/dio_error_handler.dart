import 'package:dio/dio.dart';
import 'package:nortus/src/domain/exceptions/app_dio_exception.dart';

class DioErrorHandler {
  static AppDioException handle(dynamic error) {
    if (error is AppDioException) return error;

    if (error is DioException) {
      return _handleDioException(error);
    }

    return GenericDioException();
  }

  static AppDioException _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.connectionError:
        return ConnectionError();

      default:
        return GenericDioException();
    }
  }

  static AppDioException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? 500;

    switch (statusCode) {
      case 400: return BadRequestException();
      case 401: return UnauthorizedException();
      case 404: return NotFoundException();
      case 408: return TimeoutException();
      case 500: return InternalServerException();
      case 502: return BadGatewayException();
      case 503: return ServiceUnavailableException();
      default: return GenericDioException();
    }
  }
}