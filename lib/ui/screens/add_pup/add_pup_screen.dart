import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/common/widgets/custom_app_bar.dart';
import 'package:my_pups/ui/common/widgets/text/app_regular_text.dart';
import 'package:my_pups/ui/common/widgets/text_form_field/app_textform_field.dart';

class AddPupScreen extends StatelessWidget {
  const AddPupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PupsBloc>(
      create: (_) => PupsBloc(pupsRepository: PupsRepository()),
      child: const AddPupView(),
    );
  }
}

class AddPupView extends StatefulWidget {
  const AddPupView({
    Key? key,
  }) : super(key: key);
  @override
  State<AddPupView> createState() => _AddPupViewState();
}

class _AddPupViewState extends State<AddPupView> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> pupFields = [
    'Name',
    'Sex',
    'Breed',
    'Age',
    'Owner',
    // 'Image',
    'Pet Clinic',
    'Vet\'s Name',
    'Vet\'s Notes',
    'Last Vet Visit',
    'Next Vet Visit'
  ];

  /// return a list of controllers for each pupField
  late final controllers = pupFields.map((pupField) {
    return TextEditingController();
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Add Pup',
          hasBackButton: true,
          hasRightIcon: false,
          leftIcon: Icons.arrow_back_ios,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 660,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pupFields.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextFormField(
                        label: pupFields[index],
                        controller: controllers[index],
                        hasOnlyNumbers:
                            pupFields[index] == 'Age' ? true : false,
                        borderColor: Colors.pinkAccent.withOpacity(0.9),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: TextButton(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: AppRegularText(
                      text: 'Add Pup',
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final pup = Pup(
                        name: controllers[0].text,
                        sex: controllers[1].text,
                        breed: controllers[2].text,
                        age: int.parse(controllers[3].text),
                        owner: controllers[4].text,
                        imageUrl: '',
                        hasClinic: false,
                        petClinic: controllers[5].text,
                        vetName: controllers[6].text,
                        vetNotes: controllers[7].text,
                        lastVisit: controllers[8].text,
                        nextVisit: controllers[9].text,
                        id: '',
                      );
                      context.read<PupsBloc>().add(
                            AddPup(pup: pup),
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pup Added successfully'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error adding pup. Please try again.'),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
