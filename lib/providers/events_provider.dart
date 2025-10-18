// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/model.dart';

// // Provider definition at the root level for app-wide state persistence
// final eventListProvider = StateNotifierProvider<EventListNotifier, List<Event>>((ref) => EventListNotifier());

// final upcomingEventsProvider = Provider<List<Event>>((ref) {
//   final events = ref.watch(eventListProvider);
//   return events
//       .where((event) => event.date.isAfter(DateTime.now()))
//       .toList()
//       ..sort((a, b) => a.date.compareTo(b.date));
// });

// final favoriteEventsProvider = Provider<List<Event>>((ref) {
//   final events = ref.watch(eventListProvider);
//   return events.where((event) => event.isFavorite).toList();
// });

// class EventListNotifier extends StateNotifier<List<Event>> {
//   EventListNotifier() : super([]);

//   void loadEvents(List<Event> events) {
//     state = events;
//   }

//   void addEvent(Event event) {
//     if (_validateEvent(event)) {
//       state = [...state, event];
//     } else {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }
//   }

//   void removeEvent(String id) {
//     state = state.where((event) => event.id != id).toList();
//   }

//   void toggleFavorite(String id) {
//     state = state.map((event) {
//       if (event.id == id) {
//         return Event(
//           id: event.id,
//           title: event.title,
//           date: event.date,
//           description: event.description,
//           isFavorite: !event.isFavorite,
//         );
//       }
//       return event;
//     }).toList();
//   }

//   void updateEvent(Event updatedEvent) {
//     if (!_validateEvent(updatedEvent)) {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }

//     final eventExists = state.any((event) => event.id == updatedEvent.id);
//     if (!eventExists) {
//       throw ArgumentError('Cannot update non-existent event');
//     }

//     state = state.map((event) {
//       if (event.id == updatedEvent.id) {
//         return updatedEvent;
//       }
//       return event;
//     }).toList();
//   }

//   bool _validateEvent(Event event) {
//     return event.title.trim().isNotEmpty && 
//            event.description.trim().isNotEmpty &&
//            event.date.isAfter(DateTime.now().subtract(const Duration(days: 1))); // Prevents events in the past
//   }
// }

// class EventListNotifier extends StateNotifier<List<Event>> {
//   EventListNotifier() : super([]);

//   void loadEvents(List<Event> events) {
//     state = events;
//   }

//   void addEvent(Event event) {
//     if (_validateEvent(event)) {
//       state = [...state, event];
//     } else {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }
//   }

//   void removeEvent(String id) {
//     state = state.where((event) => event.id != id).toList();
//   }

//   void toggleFavorite(String id) {
//     state = state.map((event) {
//       if (event.id == id) {
//         return Event(
//           id: event.id,
//           title: event.title,
//           date: event.date,
//           description: event.description,
//           isFavorite: !event.isFavorite,
//         );
//       }
//       return event;
//     }).toList();
//   }

//   void updateEvent(Event updatedEvent) {
//     if (!_validateEvent(updatedEvent)) {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }

//     final eventExists = state.any((event) => event.id == updatedEvent.id);
//     if (!eventExists) {
//       throw ArgumentError('Cannot update non-existent event');
//     }

//     state = state.map((event) {
//       if (event.id == updatedEvent.id) {
//         return updatedEvent;
//       }
//       return event;
//     }).toList();
//   }

//   bool _validateEvent(Event event) {
//     return event.title.trim().isNotEmpty && 
//            event.description.trim().isNotEmpty &&
//            event.date.isAfter(DateTime.now().subtract(const Duration(days: 1))); // Prevents events in the past
//   }

//   // Convenience getters
//   List<Event> get favoriteEvents => 
//     state.where((event) => event.isFavorite).toList();

//   List<Event> get upcomingEvents =>
//     state.where((event) => event.date.isAfter(DateTime.now()))
//          .toList()
//          ..sort((a, b) => a.date.compareTo(b.date));
// }

// final eventsProvider = StateNotifierProvider<EventListNotifier, List<Event>>((ref) {
//   return EventListNotifier();
// });

// class EventListNotifier extends StateNotifier<List<Event>> {
//   EventListNotifier() : super([]);

//   void loadEvents(List<Event> events) {
//     state = events;
//   }

//   void addEvent(Event event) {
//     if (_validateEvent(event)) {
//       state = [...state, event];
//     } else {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }
//   }

//   void removeEvent(String id) {
//     state = state.where((event) => event.id != id).toList();
//   }

//   void toggleFavorite(String id) {
//     state = state.map((event) {
//       if (event.id == id) {
//         return Event(
//           id: event.id,
//           title: event.title,
//           date: event.date,
//           description: event.description,
//           isFavorite: !event.isFavorite,
//         );
//       }
//       return event;
//     }).toList();
//   }

//   void updateEvent(Event updatedEvent) {
//     if (!_validateEvent(updatedEvent)) {
//       throw ArgumentError('Invalid event: Title and description cannot be empty');
//     }

//     final eventExists = state.any((event) => event.id == updatedEvent.id);
//     if (!eventExists) {
//       throw ArgumentError('Cannot update non-existent event');
//     }

//     state = state.map((event) {
//       if (event.id == updatedEvent.id) {
//         return updatedEvent;
//       }
//       return event;
//     }).toList();
//   }

//   bool _validateEvent(Event event) {
//     return event.title.trim().isNotEmpty && 
//            event.description.trim().isNotEmpty &&
//            event.date.isAfter(DateTime.now().subtract(const Duration(days: 1))); // Prevents events in the past
//   }

//   // Convenience getters
//   List<Event> get favoriteEvents => 
//     state.where((event) => event.isFavorite).toList();

//   List<Event> get upcomingEvents =>
//     state.where((event) => event.date.isAfter(DateTime.now()))
//          .toList()
//          ..sort((a, b) => a.date.compareTo(b.date));
// }