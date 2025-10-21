import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool isFavorite;

  Event({
    String? id,
    required this.title,
    required this.date,
    required this.description,
    this.isFavorite = false,
  }) : id = id ?? const Uuid().v4();
}
