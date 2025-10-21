import 'package:hive/hive.dart';
import '../models/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

final eventBoxProvider = Provider<Box<Event>>((ref) {
  return Hive.box<Event>("events");
});

final eventListProvider = StateNotifierProvider<EventNotifier, List<Event>>((
  ref,
) {
  final box = ref.watch(eventBoxProvider);
  return EventNotifier(box);
});

class EventNotifier extends StateNotifier<List<Event>> {
  final Box<Event> box;

  EventNotifier(this.box) : super(box.values.toList());

  void addEvent(String title, String description, DateTime date) {
    final id = Uuid().v4();
    final event = Event(
      id: id,
      title: title,
      description: description,
      date: date,
    );

    box.put(id, event);
    state = box.values.toList();
  }

  void updateEvent(String id, String title, String description, DateTime date) {
    final event = box.get(id);
    if (event != null) {
      event.title = title;
      event.description = description;
      event.date = date;
      event.save();
      state = box.values.toList();
    }
  }

  void deleteEvent(String id) {
    box.delete(id);
    state = box.values.toList();
  }

  void toggleFav(String id) {
    final event = box.get(id);
    if (event != null) {
      event.isFavorite = !event.isFavorite;
      event.save();
      state = box.values.toList();
    }
  }

  void completeEvent(String id) {
    final event = box.get(id);
    if (event != null) {
      if (event.date.isAfter(DateTime.now())) {
        event.isComplete = true;
        event.save();
        state = box.values.toList();
      }
    }
  }
}
