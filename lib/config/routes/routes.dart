import 'package:flutter/material.dart';
import 'package:potty_app/pages/add_pot_set_page.dart';
import 'package:potty_app/pages/edit_pot_page.dart';
import 'package:potty_app/pages/pot_set_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      PotSetPage.routeName: (ctx) => PotSetPage(),
      EditPotPage.routeName: (ctx) => EditPotPage(),
      AddPotSetPage.routeName: (ctx) => AddPotSetPage(),
    };
  }
}
