import 'package:flutter/material.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';

class SexWidget extends StatefulWidget {
  final Function(String?) stringCallback;

  const SexWidget({
    Key? key,
    required this.stringCallback,
  }) : super(key: key);

  @override
  _SexWidgetState createState() => _SexWidgetState();
}

class _SexWidgetState extends State<SexWidget> {
  var dropDownSelection = 'Male';
  final sexValues = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 260),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.yellow.shade800, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppRegularText(text: 'Choose sex', color: Colors.black),
            const SizedBox(width: 15),
            DropdownButton(
              value: dropDownSelection,
              hint: const AppRegularText(
                  text: 'Sex', size: 17, color: Colors.black),
              items: sexValues.map((item) {
                return DropdownMenuItem(
                    value: item,
                    child: AppRegularText(
                        text: item, size: 20, color: Colors.black));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropDownSelection = newValue!;
                });
                widget.stringCallback(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
