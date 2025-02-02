class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Exception) {
      return error.toString();
    } else {
      return "An unknown error occurred";
    }
  }
}
