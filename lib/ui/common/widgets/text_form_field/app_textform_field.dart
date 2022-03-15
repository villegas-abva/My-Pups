import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    required this.label,
    this.hasIcon = false,
    this.icon = Icons.search,
    this.borderColor = Colors.black,
    required this.controller,
    this.hasOnlyNumbers = false,
    this.hasPrefixIcon = false,
    this.labelColor = Colors.pinkAccent,
    this.isPassword = false,
  }) : super(key: key);
  final String label;
  final bool hasIcon;
  final IconData? icon;
  final TextEditingController controller;
  final bool hasOnlyNumbers;
  final bool hasPrefixIcon;
  final Color borderColor;
  final Color labelColor;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          hasOnlyNumbers ? TextInputType.number : TextInputType.multiline,
      inputFormatters: hasOnlyNumbers
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : [],
      controller: controller,
      obscureText: isPassword ? true : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empy';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIconColor: Colors.red,
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
