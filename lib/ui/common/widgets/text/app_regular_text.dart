import 'package:flutter/material.dart';

class AppRegularText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final bool isBold;
  const AppRegularText(
      {Key? key,
      required this.text,
      this.color = Colors.black54,
      this.size = 16,
      this.isBold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'RedHat',
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
