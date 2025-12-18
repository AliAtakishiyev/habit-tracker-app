import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class HabitList extends ConsumerWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _habitCount = ref.read(habitProvider).length;
    final habits = ref.watch(habitProvider);
    return Expanded(
      child: ListView.builder(
        itemCount: _habitCount,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return Card(child: Text("${habit.name}"));
        },
      ),
    );
  }
}
