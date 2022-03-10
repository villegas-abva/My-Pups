import 'package:flutter/material.dart';
import 'package:my_pups/shared/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';

class AddPupScreen extends StatefulWidget {
  const AddPupScreen({Key? key}) : super(key: key);

  @override
  State<AddPupScreen> createState() => _AddPupScreenState();
}

class _AddPupScreenState extends State<AddPupScreen> {
  final TextEditingController controller = TextEditingController();
  List<dynamic> pupInfo = [
    'Name',
    'Age',
    'Breed',
    'Ownwer',
    'Pet Clinic',
    'Last vet visit',
    'Next vet visit'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Add Pup',
          hasBackButton: true,
          hasRightIcon: false,
          leftIcon: Icons.arrow_back_ios,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: pupInfo.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextFormField(
                        hint: pupInfo[index], controller: controller),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
