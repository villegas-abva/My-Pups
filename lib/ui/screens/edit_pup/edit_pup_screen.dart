import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/ui/common/widgets/button/custom_button.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/circular_avatar_widget.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/rounded_image_widget.dart';
import 'package:my_pups/ui/common/widgets/clipper/bottom_clipper.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/custom_dialog/custom_dialog.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';
import 'package:my_pups/ui/screens/add_pup/sex_widget.dart';
import 'package:path/path.dart';

class EditPupScreen extends StatefulWidget {
  final Pup pup;
  const EditPupScreen({
    Key? key,
    required this.pup,
  }) : super(key: key);
  @override
  State<EditPupScreen> createState() => _EditPupScreenState();
}

class _EditPupScreenState extends State<EditPupScreen> {
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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pupMap = {
      'Name': widget.pup.name,
      // 'Sex': widget.pup.sex,
      'Age': widget.pup.age,
      'Owner': widget.pup.owner,
      'Pet Clinic': widget.pup.petClinic,
      'Vet\'s Name': widget.pup.vetName,
      'Vet\'s Notes': widget.pup.vetNotes,
      'Last Vet Visit': widget.pup.lastVisit,
      'Next Vet Visit': widget.pup.nextVisit,
    };
    final controllers = pupMap.values.map((pupField) {
      return TextEditingController(text: pupField.toString());
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
                  _buildAppBar(context: context),
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
                      pup: widget.pup,
                      pupMap: pupMap,
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
                    print(image);
                    // TODO: Edit Pup
                    try {
                      await uploadFile();
                      final pup = Pup(
                        name: controllers[0].text,
                        breed: controllers[1].text,
                        age: int.parse(controllers[2].text),
                        owner: controllers[3].text,
                        imageUrl: imageUrl ?? '',
                        hasClinic: false,
                        petClinic: controllers[4].text,
                        vetName: controllers[5].text,
                        vetNotes: controllers[6].text,
                        lastVisit: controllers[7].text,
                        nextVisit: controllers[8].text,
                        sex: dropDownSelection,
                        id: widget.pup.id,
                      );
                      context.read<PupsBloc>().add(
                            EditPup(pup: pup),
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

  Widget _buildAppBar({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
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
                  text: 'Edit Pup',
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: GestureDetector(
                  child: const Icon(Icons.delete, color: Colors.white),
                  onTap: () {
                    // Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFields(
      {required double topPadding,
      required Pup pup,
      required Map<String, dynamic> pupMap,
      required List<TextEditingController> controllers}) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Wrap(
        children: List.generate(
          pupMap.keys.length,
          (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  label: pupMap.keys.elementAt(index),
                  labelColor: Colors.yellow.shade800,
                  // textColor: Colors.black,
                  controller: controllers[index],
                  hasOnlyNumbers:
                      pupMap.keys.elementAt(index) == 'Age' ? true : false,
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
                  ? 'Pup edited succesfully'
                  : 'Error editing pup. Please try again',
              onTap: () {
                success
                    ? Navigator.pushNamed(context, '/')
                    : Navigator.pop(context);
              },
              buttonText: 'Continue');
        });
  }
}
