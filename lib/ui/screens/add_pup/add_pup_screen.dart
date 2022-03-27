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
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';
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

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();

    final file = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (file != null) {
        _photo = File(file.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    final file = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (file != null) {
        _photo = File(file.path);
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

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

  var dropDownSelection = 'Male';
  final sexValues = ['Male', 'Female'];

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
                  _buildAppBar(context: context),
                  _buildImage(topPadding: 110, context: context),
                  _buildFields(
                      topPadding: 230,
                      fields: pupFields,
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
                    controllers.forEach((element) {
                      print(element.text);
                    });

                    try {
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
                            'https://firebasestorage.googleapis.com/v0/b/my-pups-36a9a.appspot.com/o/my_pups%2Fdog_incognito.jpg.webp?alt=media&token=9b92f4eb-ee0b-4bd2-b3a7-c8e35608caee',
                        hasClinic: false,
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
                      // Future.delayed(Duration(seconds: 1));
                      Navigator.pop(context);
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
                text: 'Add Pup',
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

Widget _buildImage(
    {required double topPadding, required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(
      top: topPadding,
    ),
    child: CircularAvatarWidget(
        onClicked: () {
          _showModalBottomSheet(context);
        },
        isNetworkImage: false,
        iconColor: Colors.yellow.shade800),
  );
}

Padding _buildBottomSheet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: Wrap(
      children: [
        Column(
          children: [
            _buildBottomSheetItem(
                context: context,
                text: 'From Camera',
                icon: Icons.add_a_photo,
                onTap: () {
                  print('first');
                }),
            Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: const Divider(
                  color: Colors.black,
                  thickness: 3.0,
                  height: 26,
                )),
            _buildBottomSheetItem(
              context: context,
              text: 'From Images',
              icon: Icons.photo,
              onTap: () {
                print('second');
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBottomSheetItem(
    {required String text,
    required IconData icon,
    required BuildContext context,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      leading: Icon(icon, color: Colors.white),
      title: AppRegularText(text: text, color: Colors.white),
    ),
  );
}

_showModalBottomSheet(context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(45),
      ),
    ),
    backgroundColor: Colors.yellow.shade800,
    context: context,
    builder: (context) {
      return _buildBottomSheet(context);
    },
  );
}
