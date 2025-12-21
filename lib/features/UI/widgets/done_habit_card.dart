import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/features/providers/habit_provider.dart';

class DoneHabitCard extends ConsumerWidget {
  final habit;

  const DoneHabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      color: Color(0xffEFF6F3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(0xffBFDCCC), width: 1),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: habit.isDone,
              activeColor: Color(0xff4B9B73),
              onChanged: (value) {
                ref.read(habitProvider.notifier).editHabit(habit.key, value!);
                if (value == true) {
                  ref
                      .read(habitProvider.notifier)
                      .increaseStreak(habit.key, DateTime.now());
                }
              },
              shape: CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              "${habit.name}",
              overflow: TextOverflow.ellipsis,
              
              style: GoogleFonts.dmSans(
                decoration: TextDecoration.lineThrough,
                fontWeight: .w500,
                fontSize: 20,
                wordSpacing: 1,
              ),
            ),
          ),
          Spacer(),

          //streak
          habit.isDone
              ? Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xffFEEDD9),
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      SvgPicture.asset("assets/streak_icon.svg", width: 16),
                      SizedBox(width: 2),
                      Text(
                        "${habit.streak}",
                        style: TextStyle(
                          fontWeight: .w500,
                          color: Color(0xffF29E27),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          IconButton(
            onPressed: () {
              ref.read(habitProvider.notifier).deleteHabit(habit.key);
            },
            icon: Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
