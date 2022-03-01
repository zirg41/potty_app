import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static get lightTheme {
    return ThemeData(
      primaryColor: Colors.indigo,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      textTheme: TextTheme(
        headline1: GoogleFonts.lato(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(249, 31, 31, 31),
        ),
        bodyText1: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: const Color.fromARGB(249, 31, 31, 31),
        ),
        subtitle1: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: const Color.fromARGB(248, 71, 71, 71),
        ),
        headline2: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: const Color.fromARGB(249, 31, 31, 31),
        ),
      ),
    );
  }
}
