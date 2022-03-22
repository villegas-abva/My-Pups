import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/circular_avatar_widget.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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

  List<dynamic> pupFields = [
    'Name',
    'Sex',
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

  /// return a list of controllers for each pupField

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pupMap = {
      'Name': widget.pup.name,
      'Sex': widget.pup.sex,
      'Breed': widget.pup.breed,
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Edit Pup',
          hasBackButton: true,
          hasRightIcon: false,
          leftIcon: Icons.arrow_back_ios,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CircularAvatarWidget(
                  onClicked: () {}, imagePath: widget.pup.imageUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      imgFromCamera();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                        ),
                        height: 70,
                        child: const Center(
                            child: AppRegularText(text: 'From camera'))),
                  ),
                  GestureDetector(
                    onTap: () {
                      imgFromGallery();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                        ),
                        height: 70,
                        child: const Center(
                            child: AppRegularText(text: 'From Galery'))),
                  ),
                ],
              ),
              Wrap(
                children: List.generate(pupFields.length, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      AppTextFormField(
                          label: pupFields[index],
                          controller: controllers[index],
                          hasOnlyNumbers:
                              pupFields[index] == 'Age' ? true : false,
                          borderColor: Colors.pinkAccent.withOpacity(0.9),
                          hasValue: true,
                          value: 'hula'),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 30),
              TextButton(
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: AppRegularText(
                      text: 'Edit Pup',
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Edit Pup
                    try {
                      final pup = Pup(
                        name: controllers[0].text,
                        sex: controllers[1].text,
                        breed: controllers[2].text,
                        age: int.parse(controllers[3].text),
                        owner: controllers[4].text,
                        imageUrl: imageUrl,
                        hasClinic: false,
                        petClinic: controllers[5].text,
                        vetName: controllers[6].text,
                        vetNotes: controllers[7].text,
                        lastVisit: controllers[8].text,
                        nextVisit: controllers[9].text,
                        id: '',
                      );
                      // context.read<PupsBloc>().add(
                      //       AddPup(pup: pup),
                      //     );

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text('Pup Added successfully'),
                      //   ),
                      // );
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
