import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/database/models/user.dart';
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
      child: AddPupView(),
    );
  }
}

class AddPupView extends StatefulWidget {
  AddPupView({
    Key? key,
  }) : super(key: key);
  @override
  State<AddPupView> createState() => _AddPupViewState();
}

class _AddPupViewState extends State<AddPupView> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController ageController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController breedController = TextEditingController();
  // final TextEditingController ownerController = TextEditingController();
  // final TextEditingController petClinicController = TextEditingController();
  // final TextEditingController lastVisitController = TextEditingController();
  // final TextEditingController nextVisitController = TextEditingController();
  // final TextEditingController vetNotesController = TextEditingController();

  List<dynamic> pupFields = [
    'Name',
    'Age',
    'Breed',
    // 'Sex',
    'Owner',
    // 'Pet Clinic',
    // 'Last vet visit',
    // 'Next vet visit',
    // 'Vet\'s Notes'
  ];

  /// return a list of controllers for each pupField
  late final controllers = pupFields.map((pupField) {
    return TextEditingController();
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  final pup = Pup(
                    name: controllers[0].text,
                    age: controllers[1].text,
                    breed: controllers[2].text,
// owner: controllers[3].text,
                    imageUrl: '',
                    id: '',

                    isSelected: false,
                  );

                  if (_formKey.currentState!.validate()) {
                    try {
                      print(pup);
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
                          content: Text('Error adding pup'),
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
