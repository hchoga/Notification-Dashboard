/// Application constants following DRY principle
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // App info
  static const String appName = 'Notification Dashboard';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Cache
  static const String cacheKey = 'notification_cache';
  static const Duration cacheDuration = Duration(minutes: 5);

  // UI
  static const double defaultPadding = 16.0;
  static const double defualtBorderRadius = 8.0;
}
