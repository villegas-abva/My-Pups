import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class PupDetailsPage extends StatelessWidget {
  const PupDetailsPage({Key? key, required this.pup}) : super(key: key);
  final Pup pup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            // Pup Image
            Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pup.imageUrl),
                  fit: BoxFit.cover,
                ),
                // color: Colors.black.withOpacity(0.8),
              ),
            ),

            _buildBackDropWidget(top: 46, left: 15),
            // Back Icon
            Positioned(
              left: 20,
              top: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                ),
                color: Colors.white,
              ),
            ),

            _buildBackDropWidget(top: 46, right: 18),
            // Edit Icon
            Positioned(
              right: 20,
              top: 50,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),

            // Pup Description Container
            Positioned(
              top: 320,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                            text: pup.name,
                            color: Colors.black.withOpacity(0.8)),
                        AppLargeText(
                          text: '${pup.age.toString()} years old',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        AppLargeText(
                          text: 'Breed:',
                          color: Colors.black.withOpacity(
                            0.8,
                          ),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        AppRegularText(
                          text: pup.breed,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        AppLargeText(
                          text: 'Owner:',
                          color: Colors.black.withOpacity(
                            0.8,
                          ),
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const AppRegularText(
                          text: 'Andrew Villegas',
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppLargeText(
                      text: 'Shot History: ',
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      size: 18,
                    ),
                    const SizedBox(height: 20),
                    AppLargeText(
                      text: 'Last Visit: ',
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      size: 18,
                    ),
                    const SizedBox(height: 20),
                    AppLargeText(
                      text: 'Next Visit: ',
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      size: 18,
                    ),
                    const SizedBox(height: 20),
                    AppLargeText(
                      text: 'Vet\'s Notes: ',
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      size: 18,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildBackDropWidget({double? top, double? left, double? right}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      width: 50,
      height: 55,
      // Note: without ClipRect, the blur region will be expanded to full
      // size of the Image instead of custom size
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            25), // borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}
