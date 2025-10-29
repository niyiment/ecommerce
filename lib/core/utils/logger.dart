import 'package:logger/logger.dart';

/// Provide structure coding                                                                                                                                                                     r
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    ),
  );

  static void verbose(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.v(message, error: error, stackTrace: stackTrace);


  static void debug(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.d(message, error: error, stackTrace: stackTrace);

  static void info(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.i(message, error: error, stackTrace: stackTrace);

  static void warning(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.w(message, error: error, stackTrace: stackTrace);

  static void error(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.e(message, error: error, stackTrace: stackTrace);

  static void fatal(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.f(message, error: error, stackTrace: stackTrace);

  static void trace(String message, {dynamic error, StackTrace? stackTrace}) =>
    _logger.t(message, error: error, stackTrace: stackTrace);

}
