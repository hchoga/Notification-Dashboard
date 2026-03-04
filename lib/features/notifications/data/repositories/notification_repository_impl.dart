import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

/// Repository implementation for Notification
/// Following Dependency Inversion Principle and Repository Pattern
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _remoteDataSource.sendNotification(
        token: token,
        title: title,
        body: body,
        data: data,
      );
      return const Right(null);
    } on Exception catch (e) {
      Logger.error('Repository error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
