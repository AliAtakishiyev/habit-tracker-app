import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  bool isDone = false;

  @HiveField(2)
  DateTime? lastCompletedDate;

  @HiveField(3)
  int streak = 0;

  Habit({required this.name});
}
