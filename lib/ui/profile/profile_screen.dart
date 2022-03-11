import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pups/database/models/user.dart';
import 'package:my_pups/shared/constants/constants.dart';
import 'package:my_pups/shared/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/profile/widgets/numbers_widget.dart';
import 'package:my_pups/ui/profile/widgets/profile_appbar_widget.dart';
import 'package:my_pups/ui/profile/widgets/profile_widget.dart';
import 'package:my_pups/utils/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'My Profile',
          hasRightIcon: true,
          rightIcon: CupertinoIcons.moon_stars,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          SizedBox(height: 10),
          AppLargeText(text: user.name),
          SizedBox(height: 5),
          AppRegularText(text: user.email),
          SizedBox(height: 20),
          _buildUpgradeButton(),
          SizedBox(height: 25),
          NumbersWidget(),
          SizedBox(height: 50),
          _buildAbout(user),
        ],
      ),
    );
  }

  ElevatedButton _buildUpgradeButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Upgrade to Pro'),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
    );
  }
}

Widget _buildAbout(User user) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppLargeText(text: 'About'),
        const SizedBox(
          height: 20,
        ),
        AppRegularText(text: user.about),
      ],
    ),
  );
}
