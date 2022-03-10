import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.hint,
    this.hasIcon = false,
    this.icon = Icons.search,
    required this.controller,
    this.hasNumbers = false,
  }) : super(key: key);
  final String hint;
  final bool hasIcon;
  final IconData? icon;
  final TextEditingController controller;
  final bool hasNumbers;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // keyboardType: hasNumbers ? TextInputType.number : TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        // icon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
