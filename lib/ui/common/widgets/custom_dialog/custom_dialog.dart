import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/button/custom_button.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onTap;
  final Color textColor;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.message,
      required this.onTap,
      required this.buttonText,
      this.textColor = Colors.white,
      this.buttonTextColor = Colors.black,
      this.buttonBackgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.black,
      content: Wrap(
        children: [
          Column(
            children: [
              AppLargeText(text: title, color: textColor),
              const SizedBox(height: 10),
              AppRegularText(text: message, color: textColor),
              const SizedBox(height: 60),
              CustomButton(
                  text: buttonText,
                  textColor: buttonTextColor,
                  backgroundColor: Colors.yellow.shade800,
                  onTap: onTap)
            ],
          ),
        ],
      ),
    );
  }
}
