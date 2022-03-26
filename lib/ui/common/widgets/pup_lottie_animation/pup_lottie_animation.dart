import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PupAnimation extends StatelessWidget {
  final double height;
  final double width;
  const PupAnimation({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie_animations/pup_lottie_animation.json',
        height: height, width: width);
  }
}
