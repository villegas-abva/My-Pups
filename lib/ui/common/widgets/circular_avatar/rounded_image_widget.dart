import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_pups/shared/constants/constants.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class RoundedImageWidget extends StatefulWidget {
  final Function(File?) fileCallback;
  final String? imageUrl;
  final bool hasImage;

  const RoundedImageWidget(
      {Key? key,
      required this.fileCallback,
      this.hasImage = false,
      this.imageUrl})
      : super(key: key);

  @override
  _RoundedImageWidgetState createState() => _RoundedImageWidgetState();
}

class _RoundedImageWidgetState extends State<RoundedImageWidget> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      });
    } on PlatformException catch (e) {
      print('Failed ot pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var initialAssetImage = AppImages.incognito_image;
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
                        image: widget.hasImage
                            ? NetworkImage(widget.imageUrl.toString())
                            : AssetImage(initialAssetImage)
                                as ImageProvider<Object>,
                        fit: BoxFit.cover,
                        height: 130,
                        width: 130,
                      )),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
              onTap: () {
                _showModalBottomSheet(context);
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

  Widget _buildBottomSheet(BuildContext context) {
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
                  onTap: () async {
                    await pickImage(ImageSource.camera)
                        .then((_) => Navigator.pop(context));
                    widget.fileCallback(image);
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
                text: 'From Gallery',
                icon: Icons.photo,
                onTap: () async {
                  await pickImage(ImageSource.gallery)
                      .then((_) => Navigator.pop(context));
                  widget.fileCallback(image);
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
}
