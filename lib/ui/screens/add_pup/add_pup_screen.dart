import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AddPupScreen extends StatefulWidget {
  const AddPupScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<AddPupScreen> createState() => _AddPupScreenState();
}

class _AddPupScreenState extends State<AddPupScreen> {
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

  List<dynamic> pupFields = [
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

  /// return a list of controllers for each pupField
  late final controllers = pupFields.map((pupField) {
    return TextEditingController();
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Add Pup',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    AppRegularText(
                      text: 'Choose sex',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButton(
                        value: dropDownSelection,
                        hint: const AppRegularText(text: 'Sex'),
                        items: sexValues.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: AppRegularText(
                                text: items, color: Colors.black),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownSelection = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      imgFromCamera();
                      // Navigator.pushNamed(
                      //   context,
                      //   '/',
                      // );
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
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

                      // Navigator.of(context).pop();
                      // pickImage(ImageSource.gallery);
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2),
                        ),
                        height: 70,
                        child:
                            Center(child: AppRegularText(text: 'From Galery'))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextButton(
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(55),
                    ),
                    child: const Center(
                      child: AppRegularText(
                        text: 'Add Pup',
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
                          id: '',
                        );
                        context.read<PupsBloc>().add(
                              AddPup(pup: pup),
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pup Added successfully'),
                          ),
                        );
                        Navigator.pushNamed(
                          context,
                          '/',
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Error adding pup. Please try again.'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
