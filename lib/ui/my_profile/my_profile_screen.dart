import 'package:flutter/material.dart';

class MyProfileScren extends StatelessWidget {
  const MyProfileScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: const Center(child: Text('My Profile')),
    );
  }
}
