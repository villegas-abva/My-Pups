import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/my_pups/my_pups_view.dart';

class MyPupsScreen extends StatelessWidget {
  const MyPupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PupsBloc(
        pupsRepository: PupsRepository(),
      ),
      child: const MyPupsView(),
    );
  }
}
