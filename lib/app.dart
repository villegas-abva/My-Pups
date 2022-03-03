import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/nav/app_cubit_logics.dart';
import 'package:my_pups/bloc/nav/app_nav_cubit.dart';
import 'package:my_pups/ui/home/home_screen.dart';

class MyPupsApp extends MaterialApp {
  MyPupsApp({Key? key})
      : super(
          key: key,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(pageIndex: 1),

          // home: BlocProvider<AppCubits>(
          //   create: (context) => AppCubits(),
          //   child: const AppCubitLogics(),
          // ),
        );
}
