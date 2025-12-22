import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/features/ui/widgets/add_habit_text_field.dart';

class NoHabits extends ConsumerWidget {
  final TextEditingController controller;
  
  final FocusNode focusNode;

  const NoHabits({super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: SizedBox(
        width: double.infinity,
      
        child: Column(
          children: [

            AddHabitTextField(controller: controller, focusNode: focusNode),

            SizedBox(height: 64,),
            Text(
              "No habits yet",
              style: GoogleFonts.dmSans(
                fontWeight: .w400,
                fontSize: 22,
                color: Color(0xff737B8C),
              ),
            ),
      
            SizedBox(height: 8),
      
            Text(
              "Add your first habit above to get started",
              style: GoogleFonts.dmSans(
                fontWeight: .w400,
                fontSize: 15,
                color: Color(0xff737B8C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
