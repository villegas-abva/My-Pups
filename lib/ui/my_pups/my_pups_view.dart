import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/shared/constants/constants.dart';
import 'package:my_pups/shared/widgets/loading_widget.dart';
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
      appBar: AppBar(
        title: const Text('My Pups'),
        backgroundColor: Colors.black,
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
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20),
                  child: GestureDetector(
                    // add a new pup
                    onTap: () {
                      context.read<PupsBloc>().add(AddPup());
                    },
                    child: const Icon(
                      Icons.add_a_photo_rounded,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: AppLargeText(
                      text: 'All your pups\'s records in one place',
                      color: Colors.red),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.state.pups.length,
                      itemBuilder: (context, index) {
                        var pup = widget.state.pups[index];
                        return _buildCard(context: context, pup: pup);
                      }),
                ),
                const SizedBox(height: 15),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            color: Colors.red,
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

Widget _buildCard({required BuildContext context, required Pup pup}) {
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
            colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.xor),
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
                        style:
                            AppTextStyles.RedHat.copyWith(color: Colors.white),
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
                        style:
                            AppTextStyles.RedHat.copyWith(color: Colors.white),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
