import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/app.dart';
import 'package:my_pups/bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyPupsApp());
}
