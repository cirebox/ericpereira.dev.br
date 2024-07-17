import 'package:flutter/foundation.dart';

abstract class Failure {
  final String errorMessage;

  Failure({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
    // ErrorReport.externalFailureError(exception, stackTrace, label);
  }
}

abstract class INotInternetConnection extends Failure {
  INotInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class UnknownError extends Failure {
  UnknownError({
    String errorMessage = 'Unknown Error',
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class NotInternetConnection extends INotInternetConnection {}

class NotDataFound extends Failure {}

class FailureRequest extends Failure {
  FailureRequest({
    String errorMessage = 'Falha ao realizar requisição',
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class Unauthorized extends Failure {
  Unauthorized({
    String errorMessage = 'Usuário não autorizado',
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class InvalidValue extends Failure {}

class DatasourceResultNull extends Failure {}
