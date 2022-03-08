import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.mainColor,
      textTheme: TextTheme(
        headline1: GoogleFonts.lato(
          fontSize: 21,
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
      scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
    );
  }
}

class CustomColors {
  static const overallocatedColor = Colors.red;
  static const unallocatedColor = Colors.orange;
  static const mainColor = Colors.indigo;
}
