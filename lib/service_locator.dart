import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/notifications/data/datasources/notification_remote_datasource.dart';
import 'features/notifications/data/repositories/notification_repository_impl.dart';
import 'features/notifications/domain/repositories/notification_repository.dart';
import 'features/notifications/domain/usecases/notification_usecases.dart';
import 'features/notifications/presentation/bloc/notification_cubit.dart';

/// Service Locator for Dependency Injection
/// Following Dependency Inversion Principle
final getIt = GetIt.instance;

/// Initialize all dependencies
void setupServiceLocator() {
  // Register HTTP Client
  getIt.registerSingleton<http.Client>(http.Client());

  // Register Firebase Token Data Source
 
  // Register Remote Data Source
  getIt.registerSingleton<NotificationRemoteDataSource>(
    NotificationRemoteDataSourceImpl(
      httpClient: getIt<http.Client>(),
      baseUrl: 'https://api.example.com', // Replace with your API base URL
    ),
  );

  // Register Repository
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(getIt<NotificationRemoteDataSource>()),
  );

  getIt.registerSingleton<SendNotification>(
    SendNotification(getIt<NotificationRepository>()),
  );

  // Register Cubit
  getIt.registerSingleton<NotificationCubit>(
    NotificationCubit(
      sendNotificationUseCase: getIt<SendNotification>(),
    ),
  );
}
