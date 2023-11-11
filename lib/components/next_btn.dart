

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/screens/homepage.dart';

class NextButton extends StatefulWidget {
  const NextButton({super.key,});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            isLoading = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
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
        child: !isLoading ? Text(
          'Next',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12.0, 
            fontWeight: FontWeight.bold

          ),
        ) : CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}