import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pups/auth.dart';
import 'package:my_pups/bloc/pups/pups_bloc.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';
import 'package:my_pups/ui/common/widgets/pup_lottie_animation/pup_lottie_animation.dart';
import 'package:my_pups/ui/screens/add_pup/add_pup_screen.dart';
import 'package:my_pups/ui/screens/auth/login/login_screen.dart';
import 'package:my_pups/ui/screens/auth/register/register_screen.dart';
import 'package:my_pups/ui/screens/edit_pup/edit_pup_screen.dart';
import 'package:my_pups/ui/screens/home/home_screen.dart';
import 'package:my_pups/ui/screens/my_pups/my_pups_screen.dart';
import 'package:my_pups/ui/screens/profile/edit_profile_screen.dart';
import 'package:my_pups/ui/screens/profile/profile_screen.dart';
import 'package:my_pups/ui/screens/pup_details/pup_details_screen.dart';

class AppRouter {
  final PupsBloc _pupsBloc = PupsBloc(pupsRepository: PupsRepository())
    ..add(LoadPups());

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {

      // Home
      case '/':
        // return MaterialPageRoute(
        //     builder: (_) => BlocProvider.value(
        //         value: _pupsBloc, child: const AddPupScreen()));

        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _pupsBloc, child: const HomeScreen()));

      // return MaterialPageRoute(builder: (_) => const RoundedImageScreen());

      case '/pupAnimation':
        return MaterialPageRoute(
            builder: (_) => const PupAnimation(height: 300, width: 300));

      // Auth
      case '/auth':
        return MaterialPageRoute(builder: (_) => const Auth());

      case '/login':
        var data = routeSettings.arguments as Function;
        return MaterialPageRoute(
            builder: (_) => LoginScreen(toggleScreen: data));

      case '/register':
        var data = routeSettings.arguments as Function;
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(
                  toggleScreen: data,
                ));

      // Pups
      case '/myPups':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _pupsBloc, child: const MyPupsScreen()));

      case '/pupDetails':
        var data = routeSettings.arguments as Pup;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _pupsBloc, child: PupDetailsScreen(pup: data)));

      case '/addPup':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _pupsBloc, child: const AddPupScreen()));

      case '/editPup':
        var data = routeSettings.arguments as Pup;

        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _pupsBloc, child: EditPupScreen(pup: data)));

      // Profile
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/editProfile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    _pupsBloc.close();
  }
}
