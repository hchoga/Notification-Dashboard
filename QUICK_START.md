# Quick Start Guide

## Prerequisites
- Flutter SDK (>= 3.9.2)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

## Setup Instructions

### 1. Install Dependencies
```bash
cd notification_dashboard
flutter pub get
```

### 2. Run the Application

**For Web:**
```bash
flutter run -d web
```

**For Mobile (Android/iOS):**
```bash
flutter run
```

**For Desktop (Windows/macOS/Linux):**
```bash
flutter run -d windows
# or
flutter run -d macos
# or
flutter run -d linux
```

## Project Features

### ✨ Implemented Features

- **Clean Architecture**: Properly organized project structure
- **SOLID Principles**: Well-designed, maintainable code
- **BLoC State Management**: Predictable state management
- **Error Handling**: Type-safe error handling with Either pattern
- **Dependency Injection**: Using GetIt service locator
- **Notification Dashboard**: Fully functional UI
- **API Integration**: Ready for REST API integration
- **Dark Mode Support**: Light and dark themes included
- **Responsive Design**: Mobile and web compatible

### 🎯 Notification Dashboard Features

1. **View Notifications**: Display all notifications
2. **Unread Count**: Badge showing unread notification count
3. **Mark as Read**: Mark individual notifications as read
4. **Delete Notification**: Remove single notifications
5. **Clear All**: Clear all notifications at once
6. **Refresh**: Manually refresh notification list
7. **Error Handling**: Graceful error state with retry option
8. **Loading State**: Loading indicator during data fetch
9. **Empty State**: User-friendly empty state message
10. **Category Colors**: Different colors for different notification types

## File Structure Guide

### Adding a New API Endpoint

1. **Add Use Case** in `domain/usecases/`
   ```dart
   class YourNewUseCase implements UseCase<ReturnType, ParamType> {
     @override
     Future<Either<Failure, ReturnType>> call(ParamType params) {
       return _repository.yourMethod(params);
     }
   }
   ```

2. **Add BLoC Event** in `presentation/bloc/`
   ```dart
   class YourNewEvent extends NotificationEvent {
     const YourNewEvent();
   }
   ```

3. **Add BLoC State** in `presentation/bloc/`
   ```dart
   class YourNewState extends NotificationState {
     const YourNewState();
   }
   ```

4. **Handle Event in BLoC**
   ```dart
   on<YourNewEvent>(_onYourNewEvent);
   
   Future<void> _onYourNewEvent(
     YourNewEvent event,
     Emitter<NotificationState> emit,
   ) async {
     // Your logic here
   }
   ```

5. **Register in Service Locator** in `service_locator.dart`
   ```dart
   getIt.registerSingleton<YourNewUseCase>(
     YourNewUseCase(getIt<YourRepository>()),
   );
   ```

### Configuring API Endpoints

Edit `lib/core/constants/app_constants.dart`:

```dart
static const String baseUrl = 'https://your-api.com';
static const Duration apiTimeout = Duration(seconds: 30);
```

### Customizing Theme

Edit `lib/core/theme/app_theme.dart`:

```dart
// Change primary color
static const Color primaryColor = Color(0xFF6200EE);

// Customize text styles
static TextTheme _buildTextTheme() {
  // Modify text styles here
}
```

## Key Components Explained

### BLoC (notification_bloc.dart)

The BLoC handles all business logic for notifications:

```dart
// Trigger an event
context.read<NotificationBloc>().add(
  const FetchNotificationsEvent()
);

// Listen to state changes
BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    if (state is NotificationLoading) return LoadingWidget();
    if (state is NotificationLoaded) return NotificationsListWidget();
    if (state is NotificationError) return ErrorWidget();
    return SizedBox.shrink();
  },
);
```

### Failure Handling

All API calls return `Either<Failure, T>`:

```dart
final result = await usecase(params);

result.fold(
  // Failure case
  (failure) {
    print('Error: ${failure.message}');
    // Show error to user
  },
  // Success case
  (data) {
    print('Success: $data');
    // Use data
  },
);
```

## Debugging Tips

### Enable Logs
```dart
// Logger is already integrated
Logger.info('Your message');
Logger.error('Error message');
Logger.debug('Debug info');
```

### BLoC Event Tracking
Add this to see all events/states:

```dart
// In main.dart after setupServiceLocator()
Bloc.observer = MyBlocObserver();

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition: ${transition.currentState} -> ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error: $error');
  }
}
```

## Testing

### Unit Testing Use Cases
```dart
test('GetNotifications should return list of notifications', () async {
  // Arrange
  when(mockRepository.getNotifications())
      .thenAnswer((_) async => Right(testNotifications));

  // Act
  final result = await usecase(NoParams());

  // Assert
  expect(result, Right(testNotifications));
  verify(mockRepository.getNotifications()).called(1);
});
```

### BLoC Testing
```dart
blocTest<NotificationBloc, NotificationState>(
  'emits [NotificationLoading, NotificationLoaded] when FetchNotificationsEvent is added',
  build: () => notificationBloc,
  act: (bloc) => bloc.add(const FetchNotificationsEvent()),
  expect: () => [
    const NotificationLoading(),
    NotificationLoaded(notifications: testNotifications),
  ],
);
```

## Common Issues & Solutions

### Issue: Dependency not registered
**Solution**: Check `service_locator.dart` and ensure all dependencies are registered in `setupServiceLocator()`

### Issue: BLoC not updating UI
**Solution**: Ensure you're using `BlocBuilder` or `BlocListener` and that the state has changed (states should be different objects)

### Issue: API call failing
**Solution**: Check `baseUrl` in `app_constants.dart` and ensure internet connectivity

### Issue: Hot reload not working
**Solution**: Use hot restart (`flutter run` + 'r' key multiple times)

## Performance Tips

1. **Use `const` constructors** - Avoid unnecessary rebuilds
2. **Limit rebuilds** - Use `BlocSelector` to rebuild only when specific state changes
3. **Cache data** - Implement caching layer in repository
4. **Lazy load** - Implement pagination for large lists
5. **Optimize images** - Compress notification images before displaying

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture Guide](https://resocoder.com/clean-architecture-flutter/)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [GetIt Package](https://pub.dev/packages/get_it)
- [Dartz Package](https://pub.dev/packages/dartz)

## Support & Contribution

For issues or improvements:
1. Check existing documentation
2. Review error logs
3. Test with mock data
4. Check BLoC state transitions

---

**Happy Coding! 🚀**
