import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  PasswordTextField({required this.controller});

  @override
  State<PasswordTextField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 20),
      width: 300,
      child: TextFormField(
        controller: widget.controller,
        style: GoogleFonts.poppins(color: const Color(0xFF1C1C1C), fontSize: 12),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF2F2F2), // Background color
            hintText: 'Password', // Hint text
            hintStyle: GoogleFonts.poppins(color: Color(0xFF1C1C1C), fontSize: 12, fontWeight: FontWeight.w600), // Hint text color
            contentPadding: const EdgeInsets.all(10.0), // Circular border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // Circular border radius
              borderSide: BorderSide.none, // Remove the default border
            ),
            prefixIcon: const Icon(
              Icons.lock, // Lock icon
              color: Color(0xFF1C1C1C), // Icon color
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFF1C1C1C),
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
          obscureText: _obscureText, // Toggle password visibility
        ),
    );
  }
}
