class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => "AppException: $message";
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class AuthenticationException extends AppException {
  AuthenticationException(String message) : super(message);
}

class DatabaseException extends AppException {
  DatabaseException(String message) : super(message);
}
