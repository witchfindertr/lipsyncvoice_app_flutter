

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          // Add your button click action here
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1C1C1C)), // Background color
          minimumSize: MaterialStateProperty.all<Size>(Size(300.0, 50.0)), // Button width
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Circular border radius
            ),
          ),
        ),
        child: Text(
          'Next',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12.0, 
            fontWeight: FontWeight.bold

          ),
        ),
      ),
    );
  }
}