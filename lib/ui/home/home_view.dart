import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups_overview/pups_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Pups!')),
        body: BlocBuilder<PupsBloc, PupsState>(builder: (context, state) {
          switch (state.status) {
            case PupsStatus.initial:
              return _buildApiCallSimulation(context);
            case PupsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PupsStatus.error:
              return const Center(child: Text('Error!!'));
            case PupsStatus.empty:
              return SizedBox.shrink();
            case PupsStatus.success:
              return _buildPupsList(context, state);
          }
        }));
  }
}

Widget _buildPupsList(context, state) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: state.pups.length,
          itemBuilder: (context, index) {
            var pup = state.pups[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  print('pup : ${pup.name} tapped!!');
                  context.read<PupsBloc>().add(TogglePup(pup: pup));
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: pup.isSelected ? Colors.red : Colors.grey,
                      border: Border.all(width: pup.isSelected ? 4 : 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            pup.name,
                            style:
                                TextStyle(fontSize: pup.isSelected ? 35 : 25),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pup.breed,
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pup.age.toString(),
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
            context.read<PupsBloc>().add(LoadPups());
          },
        ),
      ],
    ),
  );
}
