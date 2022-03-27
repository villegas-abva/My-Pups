import 'package:flutter/material.dart';

class CircularAvatarWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String imageUrl;
  final Color iconColor;
  final bool isNetworkImage;

  const CircularAvatarWidget(
      {Key? key,
      required this.onClicked,
      this.imageUrl = 'assets/images/pup_incognito.jpeg',
      this.iconColor = Colors.blue,
      this.isNetworkImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic image = NetworkImage(imageUrl);
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: isNetworkImage
                    ? image
                    : const AssetImage('assets/images/pup_incognito.jpeg'),
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor,
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
