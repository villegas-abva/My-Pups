import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/shared/constants/messages_constants.dart';
import 'package:my_pups/ui/common/widgets/button/custom_button.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/rounded_image_widget.dart';
import 'package:my_pups/ui/common/widgets/clipper/bottom_clipper.dart';
import 'package:my_pups/ui/common/widgets/custom_dialog/custom_dialog.dart';
import 'package:my_pups/ui/common/widgets/pup_lottie_animation/pup_lottie_animation.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';
import 'package:my_pups/ui/screens/add_pup/sex_widget.dart';
import 'package:path/path.dart';

class AddPupScreen extends StatefulWidget {
  const AddPupScreen({Key? key}) : super(key: key);

  @override
  _AddPupScreenState createState() => _AddPupScreenState();
}

class _AddPupScreenState extends State<AddPupScreen> {
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
              return const Center(child: CircularProgressIndicator()
                  // child: PupAnimation(height: 300, width: 300),
                  );
            // return const LoadingWidget(text: 'Loading Pups...');
            case PupsStatus.error:
              return const Center(child: Text('Error!!'));
            case PupsStatus.empty:
              return const SizedBox.shrink();
            case PupsStatus.success:
              return AddPupBody(
                context: context,
                state: state,
              );
          }
        },
      ),
    );
  }
}

class AddPupBody extends StatefulWidget {
  final BuildContext context;
  final PupsState state;
  const AddPupBody({
    Key? key,
    required this.context,
    required this.state,
  }) : super(key: key);
  @override
  State<AddPupBody> createState() => _AddPupBodyState();
}

class _AddPupBodyState extends State<AddPupBody> {
  var dropDownSelection = 'Male';
  final sexValues = ['Male', 'Female'];

  var imageUrl;
  File? image;
  final _formKey = GlobalKey<FormState>();

  File? _photo;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    const destination = 'my_pups/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(fileName);

      final upload = await ref.putFile(_photo!);

      imageUrl = (await upload.ref.getDownloadURL()).toString();
    } catch (e) {
      print('error occured');
    }
  }

  List<String> pupFields = [
    'Name',
    'Breed',
    'Age',
    'Owner',
    // 'Image',
    'Pet Clinic',
    'Vet\'s Name',
    'Vet\'s Notes',
    'Last Vet Visit',
    'Next Vet Visit'
  ];

  @override
  Widget build(BuildContext context) {
    /// return a list of controllers for each pupField
    final controllers = pupFields.map((pupField) {
      return TextEditingController();
    }).toList();

    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  _buildRoundedContainer(height: 180),
                  _buildAppBar(context: context, topPadding: 50),
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0),
                    child: RoundedImageWidget(fileCallback: (f) {
                      setState(() {
                        _photo = f!;
                      });
                    }),
                  ),
                  SexWidget(stringCallback: (sex) {
                    dropDownSelection = sex!;
                  }),
                  _buildFields(
                      topPadding: 310,
                      fields: pupFields,
                      controllers: controllers),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Save',
                textColor: Color.fromARGB(255, 70, 90, 121),
                backgroundColor: Colors.yellow.shade800,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await uploadFile();
                      final pup = Pup(
                        name: controllers[0].text,
                        breed: controllers[1].text,
                        age: int.parse(controllers[2].text),
                        owner: controllers[3].text,
                        petClinic: controllers[4].text,
                        vetName: controllers[5].text,
                        vetNotes: controllers[6].text,
                        lastVisit: controllers[7].text,
                        nextVisit: controllers[8].text,
                        sex: dropDownSelection,
                        imageUrl:
                            imageUrl ?? MessagesConstants.incognitoPupLink,
                        hasClinic: false,
                        id: '',
                      );
                      context.read<PupsBloc>().add(
                            AddPup(pup: pup),
                          );
                      _showDialog(
                        context: context,
                        success: true,
                      );
                    } catch (e) {
                      _showDialog(
                        context: context,
                        success: false,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedContainer({required double height}) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(color: Colors.yellow[800]),
      ),
    );
  }

  Widget _buildAppBar(
      {required BuildContext context, required double topPadding}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 95),
                  child: AppRegularText(
                    size: 24,
                    text: 'Add Pup',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFields(
      {required double topPadding,
      required List<String> fields,
      required List<TextEditingController> controllers}) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Wrap(
        children: List.generate(
          fields.length,
          (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  label: fields[index],
                  labelColor: Colors.yellow.shade800,
                  controller: controllers[index],
                  hasOnlyNumbers: fields[index] == 'Age' ? true : false,
                  borderColor: Colors.yellow.shade800,
                  hasValue: true,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _showDialog({required BuildContext context, required bool success}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
              title: success ? 'Success!' : 'Oh no!',
              message: success
                  ? 'Pup added succesfully'
                  : 'Error adding pup. Please try again',
              onTap: () {
                success
                    ? Navigator.pushNamed(context, '/')
                    : Navigator.pop(context);
              },
              buttonText: 'Continue');
        });
  }
}
