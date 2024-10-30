import 'package:flutter/material.dart';

import '../main.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const Appbar({Key? key, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: preferredSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade800, Colors.yellow.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.italic),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                sharedPreference.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20);
}
