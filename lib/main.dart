import 'package:flutter/material.dart';
import 'package:potty_app/pages/test_hive_page.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes/routes.dart';
import 'config/themes/light_theme.dart';

import 'pages/pots_collection_page.dart';

import 'providers/pots.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(const MyApp());
}

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
        // home: PotsCollectionPage(),
        home: TestHivePage(),
        routes: Routes.routes,
      ),
    );
  }
}
