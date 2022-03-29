import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextButton(
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(55),
            ),
            child: Center(
              child: AppRegularText(
                text: text,
                color: textColor,
                size: 25,
              ),
            ),
          ),
          onPressed: onTap),
    );
  }
}
