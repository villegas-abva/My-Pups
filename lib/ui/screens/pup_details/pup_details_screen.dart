import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/shared/widgets/actions_widget.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class PupDetailsScreen extends StatefulWidget {
  const PupDetailsScreen({
    Key? key,
    required this.pup,
  }) : super(key: key);
  final Pup pup;

  @override
  State<PupDetailsScreen> createState() => _PupDetailsScreenState();
}

class _PupDetailsScreenState extends State<PupDetailsScreen> {
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
                  image: NetworkImage(widget.pup.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            _buildBackDropWidget(top: 45, left: 14),
            // Back Icon
            Positioned(
              left: 12,
              top: 40,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20.0,
                ),
                color: Colors.white,
              ),
            ),

            _buildBackDropWidget(top: 45, right: 14),
            // Options Icon
            Positioned(
              right: 9,
              top: 40,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editPup',
                      arguments: widget.pup);
                  // TODO: Implement Modal Bottom Sheet
                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (BuildContext newContext) {
                  //       return _buildBottomSheet(context, widget.pup);
                  //     });
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20,
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
                            text: widget.pup.name,
                            color: Colors.black.withOpacity(0.8)),
                        AppLargeText(
                          text: '${widget.pup.age.toString()} years old',
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
                          text: widget.pup.breed,
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
}

Widget _buildBottomSheet(BuildContext context, Pup pup) {
  return Container(
    color: Colors.white,
    height: 140,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              size: 28,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionsWidget(
                icon: Icons.edit,
                text: 'Edit Pup',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/editPup',
                  );
                  // context.read<PupsBloc>().add(EditPup(pup: pup));
                  // Navigator.pop(context);

                  // Navigator.pushNamed(
                  //   context,
                  //   '/',
                  // );
                },
              ),
              ActionsWidget(
                icon: Icons.delete,
                text: 'Delete Pup',
                onTap: () {
                  context.read<PupsBloc>().add(DeletePup(pup: pup));
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildBackDropWidget({double? top, double? left, double? right}) {
  return Positioned(
    top: top,
    left: left,
    right: right,
    width: 35,
    height: 35,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
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
