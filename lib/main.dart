import 'package:flutter/material.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:provider/provider.dart';

import 'config/routes/routes.dart';
import 'config/themes/light_theme.dart';

import 'pages/pots_collection_page.dart';
import 'pages/pot_set_page.dart';

import 'providers/pots.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PotsCollection(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PotSet(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Potty App',
        theme: CustomTheme.lightTheme,
        home: PotsCollectionPage(),
        routes: Routes.routes,
      ),
    );
  }
}
