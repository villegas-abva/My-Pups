import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.label,
      this.hasIcon = false,
      this.icon = Icons.search,
      this.borderColor = Colors.black,
      required this.controller,
      this.hasOnlyNumbers = false,
      this.hasPrefixIcon = false,
      this.labelColor = Colors.pinkAccent,
      this.isPassword = false,
      this.hasValue = false,
      this.textColor = Colors.black})
      : super(key: key);
  final String label;
  final bool hasIcon;
  final IconData? icon;
  final TextEditingController controller;
  final bool hasOnlyNumbers;
  final bool hasPrefixIcon;
  final bool hasValue;
  final Color borderColor;
  final Color labelColor;
  final Color textColor;

  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return hasValue
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: AppRegularText(
                    text: label,
                    size: 15,
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(color: textColor, fontSize: 16),
                  keyboardType: hasOnlyNumbers
                      ? TextInputType.number
                      : TextInputType.multiline,
                  inputFormatters: hasOnlyNumbers
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]
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
                    fillColor: Colors.white,
                    prefixIconColor: Colors.white,
                    prefixIcon:
                        hasPrefixIcon ? Icon(icon) : const SizedBox.shrink(),
                    // labelText: label,
                    // prefixText: value,
                    labelStyle:
                        TextStyle(color: labelColor, fontFamily: 'RedHat'),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          )
        : _buildAppTextFormField();
  }

  Widget _buildAppTextFormField() {
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
