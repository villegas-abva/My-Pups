import 'package:flutter/material.dart';

class CircularAvatarWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String imagePath;

  const CircularAvatarWidget(
      {Key? key, required this.onClicked, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = NetworkImage(imagePath);
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: image,
                fit: BoxFit.cover,
                height: 130,
                width: 130,
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
              onTap: onClicked,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(
                      width: 3,
                      color: Colors.white,
                    )),
                child: Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
