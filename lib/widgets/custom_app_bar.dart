import 'package:flutter/material.dart';
import 'package:potty_app/pages/pots_collection_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  final String title;
  final bool isBackButtonInit;
  bool isPagePotSet = false;

  CustomAppBar({this.title, this.isBackButtonInit, this.isPagePotSet});

  void backButtonAction(BuildContext context) {
    Navigator.of(context).pop();
  }

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
                  onPressed: () => isPagePotSet
                      ? Navigator.of(context)
                          .pushReplacementNamed(PotsCollectionPage.routeName)
                      : backButtonAction(context),
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
