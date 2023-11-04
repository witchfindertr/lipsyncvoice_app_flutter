


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 300,
      child: TextFormField(
        style: GoogleFonts.poppins(color: const Color(0xFF1C1C1C), fontSize: 12),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF2F2F2), // Background color
            hintText: 'Username', // Hint text
            hintStyle: GoogleFonts.poppins(color: const Color(0xFF1C1C1C), fontSize: 12, fontWeight: FontWeight.w600), // Hint text color
            contentPadding: const EdgeInsets.all(10.0), // Circular border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // Circular border radius
              borderSide: BorderSide.none, // Remove the default border
            ),
            prefixIcon: const Icon(
              Icons.person, // Your desired icon
              color: Color(0xFF1C1C1C), // Icon color
            ),
          ),
        ),
    );
  }
}