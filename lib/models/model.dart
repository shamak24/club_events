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
  DateTime startDate;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool isFavorite;
  @HiveField(5)
  DateTime endDate;

  Event({
    String? id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.isFavorite = false,
  }) : id = id ?? const Uuid().v4();
}
