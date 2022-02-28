import 'package:flutter/material.dart';
import 'package:potty_app/pages/pot_detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potty',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: PotDetailPage(),
    );
  }
}
