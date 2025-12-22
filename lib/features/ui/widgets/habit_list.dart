import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/features/ui/widgets/add_habit_text_field.dart';
import 'package:habit_tracker_app/features/ui/widgets/done_habit_card.dart';
import 'package:habit_tracker_app/features/ui/widgets/habit_card.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class HabitList extends ConsumerWidget {
  final TextEditingController controller;

  final FocusNode focusNode;

  const HabitList({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitCount = ref.watch(habitProvider).length;
    final habits = ref.watch(habitProvider);

    final now = DateTime.now();

    

    return Expanded(
      child: ListView.builder(
        itemCount: habitCount + 1,
        itemBuilder: (context, index) {
          if (index == habitCount) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AddHabitTextField(
                controller: controller,
                focusNode: focusNode,
              ),
            );
          } else {
            final habit = habits[index];

            return SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: habit.isDone ?  DoneHabitCard(habit: habit):HabitCard(habit: habit)
              ),
            );
          }
        },
      ),
    );
  }
}
