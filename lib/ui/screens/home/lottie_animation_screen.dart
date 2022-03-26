import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/pup_lottie_animation/pup_lottie_animation.dart';

class LottieAnimationScreen extends StatefulWidget {
  const LottieAnimationScreen({Key? key}) : super(key: key);

  @override
  _LottieAnimationScreenState createState() => _LottieAnimationScreenState();
}

class _LottieAnimationScreenState extends State<LottieAnimationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: const Center(
        child: PupAnimation(height: 200, width: 200),
      ),
    );
  }
}
