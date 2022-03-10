import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAppbarWidget extends StatelessWidget {
  final BuildContext context;
  final icon = CupertinoIcons.moon_stars;

  const ProfileAppbarWidget({Key? key, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: BackButton(
          color: Colors.black,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
