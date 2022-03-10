import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? hasBackButton;
  final bool? hasRightIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.hasBackButton = false,
      this.hasRightIcon = false,
      this.leftIcon = Icons.arrow_back_ios,
      this.rightIcon = Icons.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton!
          ? GestureDetector(
              child: Icon(leftIcon, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
              },
            )
          : Container(),
      actions: hasRightIcon!
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(rightIcon, color: Colors.black),
              ),
            ]
          : [],
      title: AppRegularText(
        size: 23,
        text: title,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }
}
