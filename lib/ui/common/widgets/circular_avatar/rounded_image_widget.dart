import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class RoundedImageScreen extends StatefulWidget {
  const RoundedImageScreen({Key? key}) : super(key: key);

  @override
  _RoundedImageScreenState createState() => _RoundedImageScreenState();
}

class _RoundedImageScreenState extends State<RoundedImageScreen> {
  File? image;

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

  @override
  Widget build(BuildContext context) {
    var initialAssetImage = 'assets/images/pup_incognito.jpeg';

    // dynamic image = NetworkImage(imageUrl);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: image != null
                ? ClipOval(child: Image.file(image!, height: 300, width: 300))
                : Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: AssetImage(initialAssetImage),
                            // image: isNetworkImage
                            //     ? image
                            //     : const AssetImage('assets/images/pup_incognito.jpeg'),
                            fit: BoxFit.cover,
                            height: 170,
                            width: 170,
                            child: InkWell(
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: InkWell(
                          // onTap: onClicked,
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow.shade800,
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                )),
                            child: const Icon(Icons.edit,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          // RoundedImageWidget(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                child: AppRegularText(text: 'Camera'),
              ),
              InkWell(
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
                child: AppRegularText(text: 'Image'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedImageWidget extends StatefulWidget {
  const RoundedImageWidget({Key? key}) : super(key: key);

  @override
  _RoundedImageWidgetState createState() => _RoundedImageWidgetState();
}

class _RoundedImageWidgetState extends State<RoundedImageWidget> {
  File? image;

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

  @override
  Widget build(BuildContext context) {
    var initialAssetImage = 'assets/images/pup_incognito.jpeg';

    // dynamic image = NetworkImage(imageUrl);
    // child: Image.file(image!, height: 300, width: 300),),),

    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: image != null
                  ? Image.file(
                      image!,
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    )
                  : Ink.image(
                      image: AssetImage(initialAssetImage),
                      fit: BoxFit.cover,
                      height: 130,
                      width: 130,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
              onTap: () {
                pickImage(ImageSource.camera);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow.shade800,
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    )),
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
