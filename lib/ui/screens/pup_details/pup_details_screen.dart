import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/shared/widgets/actions_widget.dart';
import 'package:my_pups/ui/common/widgets/divider/divider_widget.dart';
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
            _buildPupImage(),
            // Back Icon
            _buildBackDropWidget(top: 45, left: 14),
            _buildIcon(
              isLeftIcon: true,
              icon: Icons.arrow_back_ios,
              left: 10,
              top: 39,
            ),
            // Options Icon
            _buildBackDropWidget(top: 45, right: 14),
            _buildIcon(isLeftIcon: false, icon: Icons.menu, right: 7, top: 39),
            // Pup Description Container
            Positioned(
              top: 425,
              child: _buildBottomContainer(widget.pup),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPupImage() {
    return Container(
      width: double.maxFinite,
      height: 550,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.pup.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIcon({
    double? left = 0,
    double? right = 0,
    double? top = 40,
    required IconData icon,
    bool isLeftIcon = true,
  }) {
    return isLeftIcon
        ? Positioned(
            left: left,
            top: top,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                icon,
                color: Colors.white,
                size: 20.0,
              ),
              color: Colors.white,
            ),
          )
        : Positioned(
            right: right,
            top: top,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/editPup', arguments: widget.pup);
              },
              icon: Icon(
                icon,
                color: Colors.white,
                size: 20.0,
              ),
              color: Colors.white,
            ),
          );
  }

  Widget _buildBottomContainer(Pup pup) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      width: MediaQuery.of(context).size.width,
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(55),
          topRight: Radius.circular(55),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(pup: pup),
            const SizedBox(height: 10),
            _buildDetailsCard(pup),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required Pup pup}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLargeText(
              text: pup.name,
              color: pup.sex == 'Male' ? Colors.blue : Colors.pinkAccent),
          AppLargeText(
              text: '${pup.age.toString()} yrs',
              color: pup.sex == 'Male' ? Colors.blue : Colors.pinkAccent),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(Pup pup) {
    return Card(
      elevation: 15,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailField(
                  text: pup.breed,
                  icon: Icons.pets_outlined,
                  isMale: pup.sex == 'Male' ? true : false),
              const DividerWidget(height: 50),
              _buildDetailField(
                  text: '30 kgs',
                  icon: Icons.scale_outlined,
                  isMale: pup.sex == 'Male' ? true : false),
              const DividerWidget(height: 50),
              _buildDetailField(
                  text: '03.02.19',
                  icon: Icons.celebration_outlined,
                  isMale: pup.sex == 'Male' ? true : false),
              const DividerWidget(height: 50),
              _buildDetailField(
                  text: pup.sex,
                  icon: Icons.male,
                  isMale: pup.sex == 'Male' ? true : false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(
      {required String text, required IconData icon, required bool isMale}) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppRegularText(
            text: text,
            color: Colors.black,
            size: 14,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          Icon(icon, size: 25, color: isMale ? Colors.blue : Colors.pinkAccent),
        ],
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
    width: 33,
    height: 33,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    ),
  );
}
