import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/features/UI/widgets/add_habit_text_field.dart';
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
                child: Card(
                  elevation: 0,
                  color: Color(0xffFCFBF7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Color(0xffE6E2DB), width: 1),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: habit.isDone,
                        onChanged: (value) {
                          ref
                              .read(habitProvider.notifier)
                              .editHabit(habit.key, value!);
                        },
                        shape: CircleBorder(),
                      ),
                      Text(
                        "${habit.name}",
                        style: GoogleFonts.dmSans(
                          fontWeight: .w500,
                          fontSize: 20,
                          wordSpacing: 1,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () { 
                          ref
                              .read(habitProvider.notifier)
                              .deleteHabit(habit.key);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
