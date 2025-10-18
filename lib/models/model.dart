import 'package:uuid/uuid.dart';

class Event {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  bool isFavorite;

  Event({
    String? id,
    required this.title,
    required this.date,
    required this.description,
    this.isFavorite = false,
  }) : id = id ?? const Uuid().v4();

  // Convert Event to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'isFavorite': isFavorite,
    };
  }

  // Create Event from Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Create copy of Event with optional parameter updates
  Event copyWith({
    String? title,
    DateTime? date,
    String? description,
    bool? isFavorite,
  }) {
    return Event(
      id: id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
