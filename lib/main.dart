import 'package:flutter/material.dart';
import 'package:potty_app/pages/pot_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potty',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.lato(
            fontSize: 25,
          ),
        ),
      ),
      home: PotDetailPage(),
    );
  }
}
