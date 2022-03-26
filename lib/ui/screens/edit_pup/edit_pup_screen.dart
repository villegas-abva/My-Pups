import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/ui/common/widgets/button/custom_button.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/circular_avatar_widget.dart';
import 'package:my_pups/ui/common/widgets/clipper/bottom_clipper.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';
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
  var imageUrl;
  File? image;
  final _formKey = GlobalKey<FormState>();

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed ot pick image: $e');
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'my_pups/';

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

  var dropDownSelection = 'Male';
  final sexValues = ['Male', 'Female'];

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
                  _buildImage(topPadding: 110, pup: widget.pup),
                  _buildFields(
                      topPadding: 230,
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Edit Pup
                    try {
                      final pup = Pup(
                        name: controllers[0].text,
                        breed: controllers[1].text,
                        age: int.parse(controllers[2].text),
                        owner: controllers[3].text,
                        imageUrl: imageUrl,
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

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pup Edited successfully'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error adding pup. Please try again.'),
                        ),
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
}

Widget _buildImage({required double topPadding, required Pup pup}) {
  return Padding(
    padding: EdgeInsets.only(
      top: topPadding,
    ),
    child: CircularAvatarWidget(
        onClicked: () {},
        imageUrl: pup.imageUrl,
        isNetworkImage: true,
        iconColor: Colors.yellow.shade800),
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
            )
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

Widget _buildBottomSheet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    child: Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSource(
                onTap: () {
                  print('kiki');
                },
                text: 'From Camera',
                icon: Icons.photo_camera),
            SizedBox(height: 20),
            _buildImageSource(
                onTap: () {
                  print('kiki');
                },
                text: 'From Gallery',
                icon: Icons.image),
          ],
        ),
      ],
    ),
  );
}

Widget _buildImageSource(
    {required Function onTap, required String text, required IconData icon}) {
  return GestureDetector(
    onTap: onTap(),
    child: Column(
      children: [
        // Icon(icon),
        // const SizedBox(height: 5),
        AppLargeText(
          text: text,
          color: Colors.yellow.shade800,
          size: 18,
        ),
      ],
    ),
  );
}
