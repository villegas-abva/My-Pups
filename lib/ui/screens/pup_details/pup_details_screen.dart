import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/screens/pup_details/pup_details_view.dart';

class PupDetailsScreen extends StatelessWidget {
  final Pup pup;
  const PupDetailsScreen({Key? key, required this.pup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PupsBloc(
        pupsRepository: PupsRepository(),
      ),
      child: PupDetailsView(
        pup: pup,
      ),
    );
  }
}
