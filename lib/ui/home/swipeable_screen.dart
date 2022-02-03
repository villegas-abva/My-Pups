import 'package:flutter/material.dart';

class SwipeableScreen extends StatefulWidget {
  const SwipeableScreen({Key? key}) : super(key: key);

  @override
  _SwipeableScreenState createState() => _SwipeableScreenState();
}

class _SwipeableScreenState extends State<SwipeableScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
