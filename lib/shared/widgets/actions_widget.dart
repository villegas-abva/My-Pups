import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class ActionsWidget extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;
  const ActionsWidget(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 5),
            AppRegularText(
              text: text,
              color: Colors.white,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
