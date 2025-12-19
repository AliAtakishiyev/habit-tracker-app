import 'package:habit_tracker_app/features/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/models/habit.dart';
import 'package:riverpod/riverpod.dart';

class HabitProvider extends Notifier<List<Habit>> {
  late final HabitRepository repository;

  @override
  List<Habit> build() {
    repository = HabitRepository();
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

  void refresh() {
    state = repository.getAllHabits();
  }
}

final habitProvider = NotifierProvider<HabitProvider, List<Habit>>(
  HabitProvider.new,
);
