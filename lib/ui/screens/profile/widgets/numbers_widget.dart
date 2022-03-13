import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we control the height of the dividers, saying
    // "it should take the height of the other widgets.."
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(context, '4.8', 'Ranking'),
          buildDivider(),
          buildButton(context, '35', 'Followers'),
          buildDivider(),
          buildButton(context, '58', 'Following'),
        ],
      ),
    );
  }
}

Widget buildButton(BuildContext context, String value, String text) {
  return MaterialButton(
    padding: EdgeInsets.symmetric(vertical: 4),
    onPressed: () {},
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppLargeText(text: value),
        const SizedBox(height: 2),
        AppRegularText(text: text),
      ],
    ),
  );
}

Widget buildDivider() {
  return Container(
    height: 30,
    child: VerticalDivider(
      color: Colors.black,
    ),
  );
}
