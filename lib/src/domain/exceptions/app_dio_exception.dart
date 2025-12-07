import 'package:nortus/src/domain/exceptions/app_exception.dart';

class AppDioException extends AppException {
  final int statusCode;

  AppDioException({
    required this.statusCode,
    required super.message,
    required super.code,
  });

  @override
  String toString() => 'AppDioException [$code]: $message';
}

class GenericDioException extends AppDioException {
  GenericDioException()
      : super(
          message: 'Ocorreu um erro inesperado.',
          code: 'GENERIC_HTTP_ERROR',
          statusCode: 0,
        );
}

class BadRequestException extends AppDioException {
  BadRequestException()
      : super(
          message: 'Ocorreu um erro de requisição.',
          code: 'BAD_REQUEST_ERROR',
          statusCode: 400,
        );
}

class UnauthorizedException extends AppDioException {
  UnauthorizedException()
      : super(
          message: 'Acesso não autorizado.',
          code: 'UNAUTHORIZED_ERROR',
          statusCode: 401,
        );
}

class NotFoundException extends AppDioException {
  NotFoundException()
      : super(
          message: 'Recurso não encontrado.',
          code: 'NOT_FOUND_ERROR',
          statusCode: 404,
        );
}

class ConnectionError extends AppDioException {
  ConnectionError()
      : super(
          message: 'Erro de conexão com o servidor.',
          code: 'CONNECTION_ERROR',
          statusCode: 0,
        );
}

class TimeoutException extends AppDioException {
  TimeoutException()
      : super(
          message: 'Tempo de conexão expirado',
          code: 'TIMEOUT_ERROR',
          statusCode: 408,
        );
}

class InternalServerException extends AppDioException {
  InternalServerException()
      : super(
          message: 'Erro no servidor.',
          code: 'INTERNAL_SERVER_ERROR',
          statusCode: 500,
        );
}

class BadGatewayException extends AppDioException {
  BadGatewayException()
      : super(
          message: 'Falha de comunicação com o servidor.',
          code: 'BAD_GATEWAY_ERROR',
          statusCode: 502,
        );
}

class ServiceUnavailableException extends AppDioException {
  ServiceUnavailableException()
      : super(
          message: 'Servidor indisponível no momento.',
          code: 'SERVICE_UNAVAILABLE_ERROR',
          statusCode: 503,
        );
}