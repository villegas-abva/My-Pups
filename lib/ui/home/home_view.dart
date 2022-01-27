import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups_overview/pups_overview_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Pups!')),
        body: BlocBuilder<PupsOverviewBloc, PupsOverviewState>(
            builder: (context, state) {
          switch (state.status) {
            case PupsOverviewStatus.initial:
              return _buildApiCallSimulation(context);
            case PupsOverviewStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PupsOverviewStatus.success:
              return _buildPupsList(context, state);
            case PupsOverviewStatus.failure:
              return const Center(child: Text('Error!!'));
          }
        }));
  }
}

Widget _buildPupsList(context, state) {
  var pups = state.pups;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: pups.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  print('pup : ${pups[index].name} tapped!!');
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            pups[index].name,
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pups[index].breed,
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pups[index].age.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          })
    ],
  );
}

Widget _buildApiCallSimulation(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'loading data...',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 15),
        const Text(
          'Simulating API call to get order preview values...',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        GestureDetector(
          child: const Text(
            'Emit Loaded State',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          onTap: () {
            context.read<PupsOverviewBloc>().add(LoadPups());
          },
        ),
      ],
    ),
  );
}
