import 'package:equatable/equatable.dart';

/// Base state for Notification BLoC
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

/// Initial state - form is ready for input
class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

/// Sending state - notification is being sent
class NotificationSending extends NotificationState {
  const NotificationSending();
}

/// Success state - notification sent successfully
class NotificationSuccess extends NotificationState {
  final String message;

  const NotificationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error state - notification sending failed
class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
