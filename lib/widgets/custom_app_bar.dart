import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  final String title;
  final bool isBackButtonInit;
  CustomAppBar({this.title, this.isBackButtonInit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBackButtonInit == null
          ? null
          : Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(20, 20, 20, 1),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                );
              },
            ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // foregroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
    );
  }
}
