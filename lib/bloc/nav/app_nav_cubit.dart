import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/bloc/nav/app_nav_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits() : super(InitialState());

  myProfilePage() {
    emit((MyProfileState()));
  }

  myPupsPage() {
    emit(
      (MyPupsState()),
    );
  }
}
