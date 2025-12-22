import 'package:habit_tracker_app/features/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/models/habit.dart';
import 'package:riverpod/riverpod.dart';

final habitProvider = NotifierProvider<HabitProvider, List<Habit>>(
  HabitProvider.new,
);

class HabitProvider extends Notifier<List<Habit>> {
  late final HabitRepository repository;

  @override
  List<Habit> build() {
    repository = HabitRepository();

    final habits = repository.getAllHabits();
    final now = DateTime.now();

    for (final habit in habits) {
      repository.checkDaily(habit.key, now);
    }

    return repository.getAllHabits();
  }

  Future<void> addHabit(String name) async {
    await repository.addHabit(name);
    state = repository.getAllHabits();
  }

  Future<void> deleteHabit(int hiveId) async {
    await repository.deleteHabit(hiveId);
    state = repository.getAllHabits();
  }

  Future<void> editHabit(int hiveId, bool status) async {
    await repository.editHabit(hiveId, status);
    state = repository.getAllHabits();
  }

  Future<void> increaseStreak(int hiveId, DateTime now) async {
    await repository.increaseStreak(hiveId, now);
    state = repository.getAllHabits();
  }

  int doneCount()  {
    return  repository.doneCount();
  }

  void refresh() {
    state = repository.getAllHabits();
  }
}


