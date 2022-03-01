import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static get lightTheme {
    return ThemeData(
      primaryColor: Colors.indigo,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.lato(
          fontSize: 25,
        ),
      ),
    );
  }
}
