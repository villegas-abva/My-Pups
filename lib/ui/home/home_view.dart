import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/shared/constants/constants.dart';
import 'package:my_pups/shared/widgets/loading_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<PupsBloc>().add(LoadPups());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<PupsBloc, PupsState>(builder: (context, state) {
        switch (state.status) {
          case PupsStatus.initial:
            return const SizedBox.shrink();
          case PupsStatus.loading:
            return const LoadingWidget(text: 'Loading Pups...');
          case PupsStatus.error:
            return const Center(child: Text('Error!!'));
          case PupsStatus.empty:
            return const SizedBox.shrink();
          case PupsStatus.success:
            return _buildBody(context, state);
        }
      })),
    );
  }
}

Widget _buildBody(context, state) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'My pups',
          textAlign: TextAlign.center,
          style: AppTextStyles.Dongle.copyWith(fontSize: 55),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.pups.length,
              itemBuilder: (context, index) {
                var pup = state.pups[index];
                return _buildCard(context, pup);
              }),
        ),
      ],
    ),
  );
}

Padding _buildCard(BuildContext context, pup) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
          onTap: () {
            context.read<PupsBloc>().add(TogglePup(pup: pup));
          },
          child: Container(
            decoration: BoxDecoration(
              color: pup.isSelected ? Colors.red : Colors.grey,
              border: Border.all(width: pup.isSelected ? 4 : 2),
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(
                  pup.imageUrl,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.xor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pup.name,
                    style: AppTextStyles.Dongle.copyWith(
                        fontSize: 70, color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                        text: 'breed: ',
                        style: AppTextStyles.RedHat.copyWith(fontSize: 22),
                        children: <TextSpan>[
                          TextSpan(
                            text: pup.breed,
                            style: AppTextStyles.RedHat.copyWith(
                                color: Colors.white),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                        text: 'age: ',
                        style: AppTextStyles.RedHat.copyWith(fontSize: 22),
                        children: <TextSpan>[
                          TextSpan(
                            text: pup.age.toString(),
                            style: AppTextStyles.RedHat.copyWith(
                                color: Colors.white),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )));
}
