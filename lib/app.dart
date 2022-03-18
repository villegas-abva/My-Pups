import 'package:flutter/material.dart';
import 'package:my_pups/ui/router/app_router.dart';

class MyPupsApp extends StatefulWidget {
  const MyPupsApp({Key? key}) : super(key: key);

  @override
  State<MyPupsApp> createState() => _MyPupsAppState();
}

class _MyPupsAppState extends State<MyPupsApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
  }
}
