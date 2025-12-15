import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Text(
            "Habit Tracker",
            textAlign: .center,
            overflow: .ellipsis,
            maxLines: 1,
            style: GoogleFonts.dmSans(fontWeight: .bold, fontSize: 34),
          ),

          SizedBox(height: 6),

          Text(
            "Build consistency, one day at time",
            textAlign: .center,
            maxLines: 1,
            overflow: .ellipsis,
            style: GoogleFonts.dmSans(
              fontWeight: .w400,
              fontSize: 18,
              wordSpacing: 1,
              color: Color(0xff737B8C),
            ),
          ),
        ],
      ),
    );
  }
}
