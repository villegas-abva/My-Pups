import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';

class RegisterScreen extends StatelessWidget {
  final Function toggleScreen;

  RegisterScreen({Key? key, required this.toggleScreen}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        toggleScreen();
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          size: 30, color: Colors.pinkAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const AppLargeText(text: 'Create Account'),
                const AppRegularText(
                    text: 'Create new account', color: Colors.grey),
                const SizedBox(height: 60),
                AppTextFormField(
                  label: 'Name',
                  controller: nameController,
                  hasPrefixIcon: true,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Email',
                  controller: emailContoller,
                  hasPrefixIcon: true,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Password',
                  controller: passwordController,
                  hasPrefixIcon: true,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Confirm Password',
                  controller: confirmPassWordController,
                  hasPrefixIcon: true,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 70),
                TextButton(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: AppRegularText(
                        text: 'Register',
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AppRegularText(
                        text: 'Already have an account?',
                      ),
                    ),
                    GestureDetector(
                      //TODO: add Register even
                      onTap: () {
                        toggleScreen();
                      },
                      child: const AppRegularText(
                          text: 'Login', color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
