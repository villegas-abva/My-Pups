import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
import 'package:my_pups/bloc/nav/app_nav_states.dart';
import 'package:my_pups/ui/screens/home/home_screen.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is InitialState) {
            return HomeScreen(
              pageIndex: 1,
            );
          } else if (state is MyProfileState) {
            return HomeScreen(
              pageIndex: 1,
            );
          } else if (state is MyPupsState) {
            return HomeScreen(
              pageIndex: 0,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
