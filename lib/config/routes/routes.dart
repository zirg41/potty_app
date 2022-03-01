import 'package:flutter/material.dart';
import 'package:potty_app/pages/pot_detail_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      PotSetPage.routeName: (ctx) => PotSetPage(),
    };
  }
}
