import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  Size get preferredSize => Size.fromHeight(60);
  CustomAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      // foregroundColor: Theme.of(context).backgroundColor,
    );
  }
}
