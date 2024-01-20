import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'intro_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Parking App',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme)),
      home: IntroScreen(),
    );
  }
}
