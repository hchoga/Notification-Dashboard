# Notification Dashboard - Clean Architecture Documentation

## Project Overview

This is a professional Flutter web dashboard built using **Clean Architecture**, **SOLID Principles**, and **BLoC State Management**. The project is production-ready and follows industry best practices.

## Architecture Layers

### 1. **Domain Layer** (Business Logic)
Located in: `lib/domain/`

The domain layer contains the core business logic and is completely independent of frameworks or external libraries.

**Components:**
- **Entities**: Pure Dart objects representing core business models (`notification.dart`)
- **Repositories (Interfaces)**: Abstract contracts defining how data should be accessed
- **Use Cases**: Business logic operations following the Single Responsibility Principle

**Key Files:**
- `domains/entities/notification.dart` - Core notification entity
- `domain/repositories/notification_repository.dart` - Repository interface
- `domain/usecases/notification_usecases.dart` - Business logic use cases

**SOLID Principles Applied:**
- Single Responsibility: Each use case handles one operation
- Dependency Inversion: Depends on abstractions (repository interface)

---

### 2. **Data Layer** (External Data Sources)
Located in: `lib/data/`

Handles data fetching from external sources (APIs, databases, cache).

**Components:**
- **Models**: Entities with JSON serialization capabilities
- **Data Sources**: Abstract interfaces for different data sources (Remote, Local Cache, etc.)
- **Repositories (Implementation)**: Concrete implementations of domain repositories

**Key Files:**
- `data/models/notification_model.dart` - Notification with JSON serialization
- `data/datasources/notification_remote_datasource.dart` - API client
- `data/repositories/notification_repository_impl.dart` - Repository implementation

**SOLID Principles Applied:**
- Liskov Substitution: Models substitute entities seamlessly
- Interface Segregation: Separate interfaces for different data sources
- Dependency Inversion: Use abstractions for data sources

---

### 3. **Presentation Layer** (UI - BLoC Pattern)
Located in: `lib/presentation/`

Handles all UI rendering and state management using BLoC.

**Components:**
- **BLoCs**: State management using `flutter_bloc`
  - `notification_event.dart` - Events triggered by user actions
  - `notification_state.dart` - States representing UI states
  - `notification_bloc.dart` - Core BLoC logic
- **Pages**: Full-screen widgets
- **Widgets**: Reusable UI components

**Key Files:**
- `presentation/bloc/notification_bloc.dart` - Main state management
- `presentation/pages/dashboard_page.dart` - Dashboard UI
- `presentation/widgets/notification_card.dart` - Notification card component
- `presentation/widgets/state_widgets.dart` - Loading, error, empty states

**SOLID Principles Applied:**
- Single Responsibility: Each event/state has one purpose
- Open/Closed: Easy to extend with new events/states
- Liskov Substitution: All states derive from base NotificationState

---

### 4. **Core Layer** (Shared Utilities)
Located in: `lib/core/`

Contains project-wide utilities, constants, and base classes.

**Components:**
- **Constants**: `app_constants.dart` - App-wide constants
- **Theme**: `theme/app_theme.dart` - Centralized theme configuration
- **Utils**: Helper functions and logging
- **Base Classes**: 
  - `failure.dart` - Error handling using Either pattern
  - `usecase.dart` - Base class for all use cases

**Key Files:**
- `core/failure.dart` - Failure types for error handling
- `core/usecase.dart` - Base use case class
- `core/constants/app_constants.dart` - Constants
- `core/theme/app_theme.dart` - Theme configuration
- `core/utils/logger.dart` - Logging utility

**SOLID Principles Applied:**
- DRY (Don't Repeat Yourself): Centralized constants and theme
- Open/Closed: Easy to add new failure types

---

## Dependency Injection

**File:** `lib/service_locator.dart`

Uses `get_it` package for service locator pattern:

```dart
setupServiceLocator() {
  // HTTP Client
  getIt.registerSingleton<http.Client>(http.Client());
  
  // Data Sources
  getIt.registerSingleton<NotificationRemoteDataSource>(
    NotificationRemoteDataSourceImpl(...)
  );
  
  // Repositories
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(...)
  );
  
  // Use Cases
  getIt.registerSingleton<GetNotifications>(
    GetNotifications(...)
  );
  
  // BLoCs
  getIt.registerSingleton<NotificationBloc>(
    NotificationBloc(...)
  );
}
```

**SOLID Principles Applied:**
- Dependency Inversion: Dependencies injected through constructors
- Single Responsibility: Service locator handles only registration

---

## Error Handling (Either Pattern)

Uses `dartz` package for functional error handling:

```dart
// Domain layer returns Either<Failure, Success>
Future<Either<Failure, List<Notification>>> getNotifications();

// In use case
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (notifications) => print('Success'),
);
```

**Benefits:**
- Explicit error handling
- Type-safe
- No exceptions thrown for expected errors
- Follows functional programming principles

---

## BLoC Pattern Explained

### Event Flow:
```
UI Widget
    ↓
Triggers Event (e.g., FetchNotificationsEvent)
    ↓
BLoC receives event
    ↓
BLoC calls Use Case
    ↓
Use Case calls Repository
    ↓
Repository fetches data
    ↓
BLoC emits new State
    ↓
UI rebuilds with new State
```

### Example Flow:
```dart
// User taps refresh button
context.read<NotificationBloc>()
    .add(const RefreshNotificationsEvent());

// BLoC processes event
_onRefreshNotifications(event, emit) {
  emit(NotificationLoading());
  
  final result = await _getNotifications(NoParams());
  
  result.fold(
    (failure) => emit(NotificationError(failure.message)),
    (notifications) => emit(NotificationLoaded(notifications)),
  );
}

// UI rebuilds with new state
BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    if (state is NotificationLoading) return LoadingWidget();
    if (state is NotificationLoaded) return NotificationsList();
    if (state is NotificationError) return ErrorWidget();
  },
)
```

---

## Project Structure Overview

```
lib/
├── core/                          # Shared utilities
│   ├── constants/
│   │   └── app_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   └── logger.dart
│   ├── failure.dart               # Error handling
│   └── usecase.dart               # Base use case
│
├── data/                          # Data sources and repositories
│   ├── datasources/
│   │   └── notification_remote_datasource.dart
│   ├── models/
│   │   └── notification_model.dart
│   └── repositories/
│       └── notification_repository_impl.dart
│
├── domain/                        # Business logic
│   ├── entities/
│   │   └── notification.dart
│   ├── repositories/
│   │   └── notification_repository.dart
│   └── usecases/
│       └── notification_usecases.dart
│
├── presentation/                  # UI Layer
│   ├── bloc/
│   │   ├── notification_bloc.dart
│   │   ├── notification_event.dart
│   │   └── notification_state.dart
│   ├── pages/
│   │   └── dashboard_page.dart
│   └── widgets/
│       ├── notification_card.dart
│       └── state_widgets.dart
│
├── service_locator.dart           # Dependency Injection
└── main.dart                      # Entry point
```

---

## SOLID Principles Implementation

### **S - Single Responsibility Principle**
- Each class has one reason to change
- Example: `GetNotifications` use case only handles fetching notifications

### **O - Open/Closed Principle**
- Open for extension, closed for modification
- Example: Can add new failure types without modifying existing code

### **L - Liskov Substitution Principle**
- Derived classes can substitute base classes
- Example: `NotificationModel` can be used anywhere `Notification` is expected

### **I - Interface Segregation Principle**
- Clients depend only on methods they use
- Example: `NotificationRemoteDataSource` has segregated methods for different operations

### **D - Dependency Inversion Principle**
- High-level modules depend on low-level abstractions
- Example: BLoC depends on abstract `NotificationRepository`, not concrete implementation

---

## How to Extend the Project

### Adding a New Feature (Example: User Management)

1. **Create Domain Layer**
   ```dart
   // domain/entities/user.dart
   class User extends Equatable {
     final String id;
     final String name;
     // ...
   }
   
   // domain/repositories/user_repository.dart
   abstract class UserRepository {
     Future<Either<Failure, User>> getUser(String id);
     // ...
   }
   
   // domain/usecases/user_usecases.dart
   class GetUser implements UseCase<User, String> {
     // ...
   }
   ```

2. **Create Data Layer**
   ```dart
   // data/models/user_model.dart
   class UserModel extends User {
     factory UserModel.fromJson(Map json) { }
     Map toJson() { }
   }
   
   // data/datasources/user_remote_datasource.dart
   abstract class UserRemoteDataSource {
     Future<UserModel> getUser(String id);
   }
   
   // data/repositories/user_repository_impl.dart
   class UserRepositoryImpl implements UserRepository {
     // ...
   }
   ```

3. **Create Presentation Layer (BLoC)**
   ```dart
   // presentation/bloc/user_event.dart
   abstract class UserEvent { }
   
   // presentation/bloc/user_state.dart
   abstract class UserState { }
   
   // presentation/bloc/user_bloc.dart
   class UserBloc extends Bloc<UserEvent, UserState> { }
   ```

4. **Register in Service Locator**
   ```dart
   // service_locator.dart
   getIt.registerSingleton<UserRepository>(
     UserRepositoryImpl(...)
   );
   
   getIt.registerSingleton<UserBloc>(
     UserBloc(...),
   );
   ```

5. **Create UI Pages/Widgets**
   ```dart
   // presentation/pages/user_page.dart
   // presentation/widgets/user_card.dart
   ```

---

## Best Practices

1. **Always use Either for error handling** - Never throw exceptions for business logic
2. **Keep business logic in use cases** - BLoC should only manage state
3. **Use Equatable for entities** - Enables reliable equality comparison
4. **Follow the unidirectional data flow** - Events → BLoC → States → UI
5. **Centralize configuration** - Use `app_constants.dart` for app-wide settings
6. **Use meaningful names** - Events should describe user actions, states should describe UI states
7. **Create separate datasources** - Different implementations for remote/local/cache
8. **Test at each layer** - Unit test use cases, repository tests, widget tests for UI

---

## Technologies Used

- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it`
- **Functional Programming**: `dartz` (Either type)
- **Equality**: `equatable`
- **Networking**: `http`
- **UI Framework**: Flutter Material 3

---

## Key Takeaways

✅ Clean Architecture separates concerns into distinct layers
✅ SOLID principles ensure maintainable, scalable code
✅ BLoC provides predictable state management
✅ Dependency injection makes testing and refactoring easier
✅ Either pattern provides type-safe error handling
✅ This structure is production-ready and follows Flutter best practices

---

## Running the Project

```bash
# Get dependencies
flutter pub get

# Run the project
flutter run -d web  # For web

# Or for mobile/desktop
flutter run
```

---

## Next Steps

1. Configure API endpoints in `core/constants/app_constants.dart`
2. Implement mock data for local testing
3. Add authentication layer if needed
4. Add caching mechanism (local datasource)
5. Add unit tests, integration tests
6. Add more features following this same pattern
