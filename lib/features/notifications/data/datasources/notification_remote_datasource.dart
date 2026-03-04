import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/utils/logger.dart';

/// Remote Datasource for Notification API calls
/// Following Interface Segregation Principle
abstract class NotificationRemoteDataSource {
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  });
}

/// Implementation of NotificationRemoteDataSource
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final http.Client httpClient;
  final String baseUrl;

  NotificationRemoteDataSourceImpl({
    required this.httpClient,
    required this.baseUrl,
  });

  @override
  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/mirage-laundry/messages:send',
      );

      final payload = {
        'message': {
          'notification': {'title': title, 'body': body},
          'topic': "Global",
        },
      };

      final response = await httpClient
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer $token', // Replace with actual access token
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        Logger.info('Notification sent successfully to token: $token');
      } else {
        Logger.error(
          'Failed to send notification: ${response.statusCode} - ${response.body}',
        );
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      Logger.error('Error sending notification: $e');
      rethrow;
    }
  }
}
