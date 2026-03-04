import 'package:flutter/foundation.dart';

/// Centralized logging utility following Dependency Inversion Principle
class Logger {
  // Prevent instantiation
  Logger._();

  static void log(String message) {
    debugPrint('📝 [LOG] $message');
  }

  static void error(String message, {StackTrace? stackTrace}) {
    debugPrint('❌ [ERROR] $message');
    if (stackTrace != null) {
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  static void warning(String message) {
    debugPrint('⚠️  [WARNING] $message');
  }

  static void info(String message) {
    debugPrint('ℹ️  [INFO] $message');
  }

  static void debug(String message) {
    debugPrint('🐛 [DEBUG] $message');
  }
}
