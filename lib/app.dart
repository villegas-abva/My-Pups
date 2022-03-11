import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/nav/app_cubit_logics.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/add_pup/add_pup_screen.dart';
import 'package:my_pups/ui/global/profile_global/profile_global_screen.dart';
import 'package:my_pups/ui/home/home_screen.dart';
import 'package:my_pups/ui/my_pups/my_pups_view.dart';
import 'package:my_pups/ui/profile/profile_screen.dart';

class MyPupsApp extends StatelessWidget {
  const MyPupsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PupsBloc>(
            create: (context) =>
                PupsBloc(pupsRepository: PupsRepository())..add(LoadPups()),
          ),
        ],
        // child: MyPupsView(),
        child: HomeScreen(
          pageIndex: 0,
        ),
      ),
    );
  }
}
