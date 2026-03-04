import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_dashboard/core/services/firebase_messaging_service.dart';

import '../../../../core/utils/logger.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/usecases/notification_usecases.dart';
import 'notification_state.dart';

/// Cubit for managing notification sending
/// Simple state management for sending notifications to devices
class NotificationCubit extends Cubit<NotificationState> {
  final SendNotification sendNotificationUseCase;

  NotificationCubit({
    required this.sendNotificationUseCase,
  }) : super(const NotificationInitial());

  /// Send notification with title and body
  /// Gets Firebase access token and calls the use case to send via FCM API
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    // Validate inputs
    if (title.trim().isEmpty) {
      emit(NotificationError(LocaleKeys.validation_title_error.tr()));
      return;
    }

    if (body.trim().isEmpty) {
      emit(NotificationError(LocaleKeys.validation_body_error.tr()));
      return;
    }

    emit(const NotificationSending());

    try {

      final params = SendNotificationParams(
        token: FirebaseMessagingService.serverToken ?? "",
        title: title,
        body: body,
        data: data,
      );

      final result = await sendNotificationUseCase(params);

      result.fold(
        (failure) {
          Logger.error('Failed to send notification: $failure');
          emit(NotificationError('Failed to send notification: $failure'));
        },
        (_) {
          Logger.info('Notification sent - Title: $title, Body: $body');
          emit(NotificationSuccess(LocaleKeys.message_success.tr()));

          // Reset form after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            if (!isClosed) emit(const NotificationInitial());
          });
        },
      );
    } catch (e) {
      Logger.error('Error sending notification: $e');
      emit(NotificationError('Failed to send notification: $e'));
    }
  }

  /// Reset form state
  void resetForm() {
    emit(const NotificationInitial());
  }
}
