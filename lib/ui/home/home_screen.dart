import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups_overview/pups_bloc.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/home/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PupsBloc(pupsRepository: PupsRepository()),
      child: const HomeView(),
    );
  }
}
