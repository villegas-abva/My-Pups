import 'package:flutter/material.dart';
import 'package:my_pups/shared/constants/constants.dart';

class LoadingWidget extends StatefulWidget {
  final String? text;

  const LoadingWidget({Key? key, required this.text}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

final Duration duration = Duration();

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    animation = Tween(begin: 180, end: 360.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(1, 3, 0.001)
                    ..rotateY(animationController.value * 5),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image(
                      height: height * 0.30,
                      image: AssetImage(AppImages.juanito_image),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.0015),
            Text(
              widget.text ?? 'Loading Pups...',
              textAlign: TextAlign.center,
              style: AppTextStyles.Dongle.copyWith(
                fontSize: 60,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
