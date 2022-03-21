import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_pups/database/models/user/user.dart';
import 'package:my_pups/ui/common/widgets/circular_avatar/circular_avatar_widget.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/screens/profile/widgets/numbers_widget.dart';
import 'package:my_pups/utils/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;
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
          const SizedBox(height: 25),
          CircularAvatarWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 10),
          AppLargeText(text: user.name),
          const SizedBox(height: 5),
          AppRegularText(text: user.email),
          const SizedBox(height: 20),
          _buildUpgradeButton(),
          const SizedBox(height: 25),
          const NumbersWidget(),
          const SizedBox(height: 50),
          _buildAbout(user),
        ],
      ),
    );
  }

  ElevatedButton _buildUpgradeButton() {
    return ElevatedButton(
        onPressed: () {},
        child: const Text('Upgrade to Pro'),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent.withOpacity(0.9),
          shape: const StadiumBorder(),
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ));
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
