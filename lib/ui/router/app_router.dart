// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_pups/bloc/pups/pups_bloc.dart';
// import 'package:my_pups/database/models/pup.dart';
// import 'package:my_pups/repository/pups_repository/pups_repository.dart';
// import 'package:my_pups/ui/screens/auth/login/login_screen.dart';
// import 'package:my_pups/ui/screens/auth/register/register_screen.dart';
// import 'package:my_pups/ui/screens/home/home_screen.dart';
// import 'package:my_pups/ui/screens/my_pups/my_pups_screen.dart';
// import 'package:my_pups/ui/screens/profile/profile_screen.dart';
// import 'package:my_pups/ui/screens/pup_details/pup_details_screen.dart';

// class AppRouter {
//   final PupsBloc _pupsBloc =
//       PupsBloc(pupsRepository: PupsRepository()..loadPups());

//   Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       // Home
//       case '/':
//         return MaterialPageRoute(builder: (_) => HomeScreen(pageIndex: 0));

//       // Auth
//       case '/login':
//         var data = routeSettings.arguments as Function;
//         return MaterialPageRoute(
//             builder: (_) => LoginScreen(toggleScreen: data));

//       case '/register':
//         var data = routeSettings.arguments as Function;
//         return MaterialPageRoute(
//             builder: (_) => RegisterScreen(
//                   toggleScreen: data,
//                 ));

//       // Pups
//       case '/myPups':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                 value: _pupsBloc, child: const MyPupsScreen()));

//       case '/pupDetails':
//         var data = routeSettings.arguments as Pup;
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                 value: _pupsBloc, child: PupDetailsScreen(pup: data)));

//       case '/addPup':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                 value: _pupsBloc, child: const ProfileScreen()));

//       // Profile
//       case '/profile':
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());

//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${routeSettings.name}'),
//             ),
//           ),
//         );
//     }
//   }

//   @override
//   void dispose() {
//     _pupsBloc.close();
//   }
// }
