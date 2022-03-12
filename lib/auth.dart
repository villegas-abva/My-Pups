import 'package:flutter/material.dart';
import 'package:my_pups/ui/screens/auth/login/login_screen.dart';
import 'package:my_pups/ui/screens/auth/register/register_screen.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool switchScreen = true;
  void toggleScreen() {
    setState(() {
      switchScreen = !switchScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add this with Bloc
    if (switchScreen) {
      return LoginScreen(toggleScreen: toggleScreen);
    } else {
      return RegisterScreen(toggleScreen: toggleScreen);
    }
  }
}
