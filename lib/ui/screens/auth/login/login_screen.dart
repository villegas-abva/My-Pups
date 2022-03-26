import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_large_text.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final Function toggleScreen;

  LoginScreen({Key? key, required this.toggleScreen}) : super(key: key);

  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Icon(Icons.person, size: 140, color: Colors.grey[300]),
                const SizedBox(height: 13),
                const AppLargeText(text: 'Welcome Back'),
                const AppRegularText(
                    text: 'Sign in to continue', color: Colors.grey),
                const SizedBox(height: 60),
                CustomTextFormField(
                  label: 'Email',
                  controller: emailContoller,
                  hasPrefixIcon: true,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: 'Password',
                  controller: passwordController,
                  hasPrefixIcon: true,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    AppRegularText(
                      text: 'Forgot Password?',
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                        text: 'Log In',
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
                        text: 'Don\'t have an account?',
                      ),
                    ),
                    GestureDetector(
                        //TODO: add Register even
                        onTap: () {
                          toggleScreen();
                        },
                        child: const AppRegularText(
                            text: 'Register', color: Colors.blue)),
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
