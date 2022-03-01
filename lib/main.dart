import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/themes/light_theme.dart';

import 'pages/pots_collection_page.dart';
import 'pages/pot_detail_page.dart';

import 'providers/pots.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PotsCollection(),
      child: MaterialApp(
        title: 'Potty App',
        theme: CustomTheme.lightTheme,
        home: PotsCollectionPage(),
      ),
    );
  }
}
