import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/notification_repository.dart';

/// Params for SendNotification use case
class SendNotificationParams {
  final String token;
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  SendNotificationParams({
    required this.token,
    required this.title,
    required this.body,
    this.data,
  });
}

/// Use case for sending notifications via FCM
class SendNotification implements UseCase<void, SendNotificationParams> {
  final NotificationRepository _repository;

  SendNotification(this._repository);

  @override
  Future<Either<Failure, void>> call(SendNotificationParams params) {
    return _repository.sendNotification(
      token: params.token,
      title: params.title,
      body: params.body,
      data: params.data,
    );
  }
}
