import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool? hasBackButton;
  final bool? hasRightIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final VoidCallback? rightIconTap;
  final bool? hasTitle;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.hasBackButton = false,
      this.hasRightIcon = false,
      this.leftIcon = Icons.arrow_back_ios,
      this.rightIcon = Icons.email,
      this.rightIconTap,
      this.hasTitle = true})
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
                child: GestureDetector(
                  onTap: rightIconTap,
                  child: Icon(rightIcon, color: Colors.black),
                ),
              ),
            ]
          : [],
      title: hasTitle!
          ? AppRegularText(
              size: 23,
              text: title,
              color: Colors.black,
            )
          : const SizedBox.shrink(),
      backgroundColor: Colors.white,
    );
  }
}
