import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/auth.dart';
import 'package:my_pups/bloc/nav/app_cubit_logics.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/router/app_router.dart';
import 'package:my_pups/ui/screens/auth/login/login_screen.dart';
import 'package:my_pups/ui/screens/auth/register/register_screen.dart';
import 'package:my_pups/ui/screens/home/home_screen.dart';

class MyPupsApp extends StatefulWidget {
  const MyPupsApp({Key? key}) : super(key: key);

  @override
  State<MyPupsApp> createState() => _MyPupsAppState();
}

class _MyPupsAppState extends State<MyPupsApp> {
  // final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateRoute: _appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PupsBloc>(
            create: (context) =>
                PupsBloc(pupsRepository: PupsRepository())..add(LoadPups()),
          ),
        ],
        child: HomeScreen(
          pageIndex: 0,
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _appRouter.dispose();
  // }
}
