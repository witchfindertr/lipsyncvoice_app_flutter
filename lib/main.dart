import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/screens/login_screen.dart';
import 'package:lipsyncvoice_app/screens/view_history.dart';

import 'mongo_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // try{
  // await MongoDatabase.connect();
  // runApp(const MyApp());
  // } catch(e){
  //   print(e.toString());
  //   runApp(const MyApp());
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lip Sync Voice Application',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen()
    );
  }
}
