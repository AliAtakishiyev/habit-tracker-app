import 'package:habit_tracker_app/features/models/habit.dart';
import 'package:hive/hive.dart';

class HabitRepository {
  final box = Hive.box<Habit>('habits');

  List<Habit> getAllHabits() {
    return box.values.toList();
  }

  Future<int> addHabit(String name) async {
    final habit = Habit(name: name);
    final id = await box.add(habit);
    return id;
  }

  Future<void> deleteHabit(int hiveID) async {
    await box.delete(hiveID);
  }

  Future<void> editHabit(int hiveId, bool status) async {
    final habit = box.get(hiveId);

    if (habit != null) {
      habit.isDone = status;
    }

    await box.put(hiveId, habit!);
  }
}
