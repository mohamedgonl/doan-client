abstract class BaseException implements Exception {
  final dynamic message;

  BaseException([this.message]);

  @override
  String toString() {
    return 'Exception: {message: $message}';
  }
}
