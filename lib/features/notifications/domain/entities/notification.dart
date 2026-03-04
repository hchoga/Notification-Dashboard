import 'package:equatable/equatable.dart';

/// Notification Entity - Core business logic object
/// Using Equatable for value comparison following SOLID principles
class Notification extends Equatable {
  final String id;
  final String title;
  final String message;
  final String category;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;

  const Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.category,
    required this.timestamp,
    required this.isRead,
    this.imageUrl,
  });

  /// Copy with method for immutability
  Notification copyWith({
    String? id,
    String? title,
    String? message,
    String? category,
    DateTime? timestamp,
    bool? isRead,
    String? imageUrl,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    message,
    category,
    timestamp,
    isRead,
    imageUrl,
  ];
}
