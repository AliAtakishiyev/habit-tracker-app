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

  Future<void> deleteNote(int hiveID) async {
    await box.delete(hiveID);
  }
}
