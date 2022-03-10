import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/shared/constants/constants.dart';
import 'package:my_pups/shared/widgets/actions_widget.dart';
import 'package:my_pups/shared/widgets/custom_app_bar.dart';
import 'package:my_pups/shared/widgets/loading_widget.dart';
import 'package:my_pups/ui/add_pup/add_pup_screen.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';
import 'package:my_pups/ui/pup_details/pup_details_screen.dart';
import 'package:my_pups/ui/pup_details/pup_details_view.dart';

class MyPupsView extends StatefulWidget {
  const MyPupsView({Key? key}) : super(key: key);

  @override
  State<MyPupsView> createState() => _MyPupsViewState();
}

class _MyPupsViewState extends State<MyPupsView>
    with AutomaticKeepAliveClientMixin<MyPupsView> {
  @override
  void initState() {
    super.initState();
    context.read<PupsBloc>().add(LoadPups());
  }

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
            title: 'My Pups',
            hasRightIcon: true,
            rightIcon: Icons.add,
            rightIconTap: () {
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
                // Container(
                //   margin: const EdgeInsets.only(top: 10, right: 20),
                //   child: ActionsWidget(
                //     text: 'Add Pup',
                //     onTap: () {
                //       // context.read<PupsBloc>().add(AddPup());
                //     },
                //     icon: Icons.add_a_photo_rounded,
                //   ),
                // ),
                // child: GestureDetector(
                //   // add a new pup
                //   onTap: () {
                //     context.read<PupsBloc>().add(AddPup());
                //   },
                //   child: const Icon(
                //     Icons.add_a_photo_rounded,
                //     size: 35,
                //   ),
                // ),

                const SizedBox(height: 15),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: AppRegularText(
                //       text: 'All your pups\'s records in one place',
                //       color: Colors.red),
                // ),
                const SizedBox(height: 10),
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
                    hint: 'Enter zip code',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: const AppRegularText(
                            text: 'Search', color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
        // ),
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
