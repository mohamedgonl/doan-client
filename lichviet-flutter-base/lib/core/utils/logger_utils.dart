import 'dart:developer' as logger;

class Logger {
  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      logger.log(
        message,
        name: 'ERROR',
        error: error,
        stackTrace: stackTrace,
      );

  static void warn(String message, [Object? error, StackTrace? stackTrace]) =>
      logger.log(
        message,
        name: 'WARN',
        error: error,
        stackTrace: stackTrace,
      );

  static void info(String message) => logger.log(
        message,
        name: 'INFO',
      );

  static void debug(String message, [Object? error, StackTrace? stackTrace]) =>
      logger.log(
        message,
        name: 'DEBUG',
        error: error,
        stackTrace: stackTrace,
      );

  static void verbose(String message) => logger.log(message, name: 'VERBOSE');
}
