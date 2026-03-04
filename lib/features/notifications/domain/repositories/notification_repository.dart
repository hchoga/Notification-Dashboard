import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';

/// Repository interface for Notification
/// Following Dependency Inversion Principle - depend on abstractions, not concretions
abstract class NotificationRepository {
  /// Send notification via FCM
  Future<Either<Failure, void>> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  });
}
