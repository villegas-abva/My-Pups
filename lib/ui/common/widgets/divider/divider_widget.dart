import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color color;
  final double height;

  const DividerWidget(
      {Key? key, this.color = Colors.black, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: VerticalDivider(color: color),
    );
  }
}
