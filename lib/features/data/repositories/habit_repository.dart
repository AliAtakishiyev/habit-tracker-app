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

  Future<void> increaseStreak(int hiveId, DateTime now) async {
    final habit = box.get(hiveId);
    if (habit == null) return;

    final last = habit.lastCompletedDate;

    if (last == null) {
      habit.streak = 1;
    } else {
      // Calculate difference in calendar days
      final lastDate = DateTime(last.year, last.month, last.day);
      final nowDate = DateTime(now.year, now.month, now.day);
      final difference = nowDate.difference(lastDate).inDays;

      if (difference == 0) {
        return; // already completed today
      } else if (difference == 1) {
        habit.streak += 1;
      } else {
        habit.streak = 1;
      }
    }

    habit.lastCompletedDate = now;
    await box.put(hiveId, habit);
  }

  Future<void> checkDaily(int hiveId, DateTime now) async {
    final habit = box.get(hiveId);
    if (habit == null) return;
    final last = habit.lastCompletedDate;

    if (last == null) {
      habit.isDone = false;
      await box.put(hiveId, habit);
      return;
    }

    final lastDate = DateTime(last.year, last.month, last.day);
    final nowDate = DateTime(now.year, now.month, now.day);
    final difference = nowDate.difference(lastDate).inDays;

    if (difference >= 1) {
      habit.isDone = false;
      await box.put(hiveId, habit);
    }
  }

  int doneCount() {
    int count = 0;
    box.values.forEach((element) {
      if (element.isDone) {
        count += 1;
      }
    });

    return count;
  }
}
