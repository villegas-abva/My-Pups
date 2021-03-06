import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/ui/common/widgets/clipper/bottom_clipper.dart';
import 'dart:math' as math;
import 'package:my_pups/shared/widgets/loading_widget.dart';
import 'package:my_pups/ui/common/widgets/pup_lottie_animation/pup_lottie_animation.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';

class MyPupsScreen extends StatefulWidget {
  const MyPupsScreen({Key? key}) : super(key: key);

  @override
  State<MyPupsScreen> createState() => _MyPupsScreenState();
}

class _MyPupsScreenState extends State<MyPupsScreen>
    with AutomaticKeepAliveClientMixin<MyPupsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<PupsBloc, PupsState>(
        builder: (context, state) {
          switch (state.status) {
            case PupsStatus.initial:
              return const SizedBox.shrink();
            case PupsStatus.loading:
              return const Center(child: PupAnimation(height: 300, width: 300));
            // return const LoadingWidget(text: 'Loading Pups...');
            case PupsStatus.error:
              return const Center(child: Text('Error!!'));
            case PupsStatus.empty:
              return const SizedBox.shrink();
            case PupsStatus.success:
              return MyPupsBody(
                context: context,
                state: state,
              );
          }
        },
      ),
    );
  }
}

class MyPupsBody extends StatefulWidget {
  final BuildContext context;
  final PupsState state;

  const MyPupsBody({Key? key, required this.context, required this.state})
      : super(key: key);

  @override
  _MyPupsBodyState createState() => _MyPupsBodyState();
}

class _MyPupsBodyState extends State<MyPupsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopContainer(),
            const SizedBox(height: 30),
            _buildPups(pups: widget.state.pups),
            const SizedBox(height: 50),
            _buildAddPupBottomSheet(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopContainer() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: BottomClipper(),
          child: Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(color: Colors.yellow[800]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                children: [
                  _buildHeader(
                      title: 'Hi, Andrew',
                      subtitle: 'Here\'s an overview of your pups')
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildHeader({required String title, required String subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppLargeText(text: title, color: Colors.white, size: 24),
      AppRegularText(text: subtitle, color: Colors.white),
    ],
  );
}

Widget _buildPups({required List<Pup> pups}) {
  return SizedBox(
    height: 380,
    width: double.infinity,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: pups.length,
        itemBuilder: (context, index) {
          final pup = pups[index];
          return _buildPupCard(context: context, pup: pup);
        }),
  );
}

Widget _buildPupCard({required BuildContext context, required Pup pup}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/pupDetails', arguments: pup);
      },
      child: Stack(
        children: [
          SizedBox(
            height: 320,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                pup.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // const SizedBox(height: 5),
          // pup info
          Positioned(
            top: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                width: 185,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRegularText(
                              text: pup.name,
                              size: 18,
                              color: Colors.black,
                              isBold: true),
                          AppRegularText(
                            text: pup.breed,
                            size: 15,
                          ),
                        ],
                      ),
                      Icon(pup.sex == 'Male' ? Icons.male : Icons.female,
                          color: pup.sex == 'Male'
                              ? Colors.blue
                              : Colors.pinkAccent),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAddPupBottomSheet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPup');
        },
        backgroundColor: Colors.yellow.shade800,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    ),
  );
}
