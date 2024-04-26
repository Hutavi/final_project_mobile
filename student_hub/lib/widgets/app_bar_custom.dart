import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showAction;

  const AppBarCustom(
      {Key? key, required this.title, this.showBackButton = true, this.showAction = true})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: showAction 
        ? <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouterName.switchAccount);
            },
          ),
        ]
        : <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
    );
  }
}
