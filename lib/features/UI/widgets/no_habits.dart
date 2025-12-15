import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoHabits extends StatelessWidget {
  const NoHabits({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: SizedBox(
        width: double.infinity,
      
        child: Column(
          children: [
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
