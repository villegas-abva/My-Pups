import 'package:flutter/material.dart';
import 'package:my_pups/ui/home/home_screen.dart';

class MyPupsApp extends MaterialApp {
  const MyPupsApp({Key? key})
      : super(
          key: key,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
}
