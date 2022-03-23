import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
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
  Hive.registerAdapter(PotSetAdapter());
  Hive.registerAdapter(PotAdapter());

  await Hive.openBox<Pot>("pots");
  await Hive.openBox<PotSet>("pot_sets");
  await Hive.openBox<Pot>('testbox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: FutureBuilder(
          future: Hive.openBox('pots'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TestHivePage();
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Text("Something went wrong");
          },
        ),

        routes: Routes.routes,
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
