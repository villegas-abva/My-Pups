import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PupAnimation extends StatelessWidget {
  const PupAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Lottie.asset(
              'assets/lottie_animations/pup_lottie_animation.json',
              height: 80,
              width: 80),
        ),
      ],
    );
  }
}
