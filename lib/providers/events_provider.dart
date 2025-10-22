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

  void addEvent(String title, String description, DateTime startDate, DateTime endDate) {
    final id = Uuid().v4();
    final event = Event(
      id: id,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );

    box.put(id, event);
    state = box.values.toList();
  }

  void updateEvent(String id, String title, String description, DateTime startDate, DateTime endDate) {
    final event = box.get(id);
    if (event != null) {
      event.title = title;
      event.description = description;
      event.startDate = startDate;
      event.endDate = endDate;
      event.save();
      state = box.values.toList();
    }
  }

  void deleteEvent(String id) {
    box.delete(id);
    state = box.values.toList();
  }
}
