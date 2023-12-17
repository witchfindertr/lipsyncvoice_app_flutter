import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/components/auth_textfield.dart';
import 'package:lipsyncvoice_app/components/next_btn.dart';
import 'package:lipsyncvoice_app/components/password_textfield.dart';
import 'package:lipsyncvoice_app/utils/global_constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<Map<String, dynamic>> signIn(String username, String password) async {

    String apiUrl =
        'http://127.0.0.1:3000/authenticate'; // Replace with your Flask server URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    usernameController.text = "";
    passwordController.text = "";

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.pagebgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lips Sync Voice",
            style: GoogleFonts.smoochSans(fontSize: 70, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 430,
              width: 800,
              decoration: BoxDecoration(
                  color: Globals.bgColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Text("Welcome",
                                style: GoogleFonts.smoochSans(
                                    fontSize: 70, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "We are glad to see you back with us",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          AuthTextField(
                            controller: usernameController,
                          ),
                          PasswordTextField(
                            controller: passwordController,
                          ),
                          NextButton(
                            username: usernameController.text,
                            password: passwordController.text,
                            onPressed: (String username, String password){},
                          )
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        "assets/ScreenHome.png",
                        width: 400,
                        height: 400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          "\u00A9 2023 Habib University Capstone Project. All Rights Reserved",
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
