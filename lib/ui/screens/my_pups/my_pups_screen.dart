import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup.dart';

import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/shared/widgets/loading_widget.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';
import 'package:my_pups/ui/screens/add_pup/add_pup_screen.dart';
import 'package:my_pups/ui/screens/pup_details/pup_details_screen.dart';

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
              return const LoadingWidget(text: 'Loading Pups...');
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
  final TextEditingController _breedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.black.withOpacity(0.2),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
            title: 'My Pups',
            hasRightIcon: true,
            rightIcon: Icons.add,
            rightIconTap: () {
              // context.read<PupsBloc>().add(AddPup());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPupScreen(),
                ),
              );
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.state.pups.length,
                      itemBuilder: (context, index) {
                        var pup = widget.state.pups[index];
                        return _buildPupCard(context: context, pup: pup);
                      }),
                ),
                const SizedBox(height: 25),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppRegularText(
                    text: 'Don\'t have a vet yet?',
                    color: Colors.red,
                    size: 16,
                  ),
                  const AppLargeText(
                    text: 'Search pet clinics nearby',
                    size: 20,
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: _breedController,
                    label: 'Enter zip code',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20)),
                      child: const AppRegularText(
                          text: 'Search', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPupCard({required BuildContext context, required Pup pup}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PupDetailsScreen(
              pup: pup,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: pup.isSelected ? Colors.red : Colors.grey,
              border: Border.all(width: pup.isSelected ? 4 : 2),
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(
                  pup.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            width: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: AppRegularText(
                text: pup.name,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
