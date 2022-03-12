import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.label,
    this.hasIcon = false,
    this.icon = Icons.search,
    this.borderColor = Colors.black,
    required this.controller,
    this.hasNumbers = false,
    this.hasPrefixIcon = false,
    this.labelColor = Colors.pinkAccent,
    this.isPassword = false,
  }) : super(key: key);
  final String label;
  final bool hasIcon;
  final IconData? icon;
  final TextEditingController controller;
  final bool hasNumbers;
  final bool hasPrefixIcon;
  final Color borderColor;
  final Color labelColor;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // keyboardType: hasNumbers ? TextInputType.number : TextInputType.number,
      controller: controller,
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        prefixIconColor: Colors.green,
        prefixIcon: hasPrefixIcon ? Icon(icon) : const SizedBox.shrink(),
        labelText: label,
        labelStyle: TextStyle(color: labelColor, fontFamily: 'RedHat'),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
