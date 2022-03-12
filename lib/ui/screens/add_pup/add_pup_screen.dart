import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
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

  final TextEditingController controller = TextEditingController();
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
  // List<TextEditingController> controllersList = [TextEditingController nameController, TextEditingController ageController,];

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
                        controller: controller,
                        // controller: controllersList[index],
                        // controller: controller,
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
                  // height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20)),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // context.read<PupsBloc>().add(const AddPup());
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
