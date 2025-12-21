import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class HabitCounter extends ConsumerWidget {
  const HabitCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);
    int count = ref.watch(habitProvider.notifier).doneCount();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        alignment: .center,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(
              value: count / habits.length,
              strokeWidth: 10,
              color: Color(0xff4B9B73),
              backgroundColor: Color(0xffEEECE6),
            ),
          ),
          Column(
            children: [
              Text(
                "${habits.length}",
                style: TextStyle(fontWeight: .bold, fontSize: 30),
              ),
              Text(
                "of $count",
                style: TextStyle(color: Color(0xff737B8C), fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
