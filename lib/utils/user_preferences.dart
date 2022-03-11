import 'package:my_pups/database/models/user.dart';

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://firebasestorage.googleapis.com/v0/b/my-pups-36a9a.appspot.com/o/my_pups%2Fjuanito.JPG?alt=media&token=893647e1-f01a-4b11-b893-392d9cb7ddf5',
    name: 'Juanito',
    email: 'juanito@jones.com',
    about:
        'Un perrito Chiweenie. Tiene 6 meses de edad pero se sigue haciendo popo mas de 60% de las veces dentro de la casa. Pero es bien tierno y le gusta sonreir. Definitivamente la mascota perfecta, aunque necesita un poco de mano dura.',
    isDarkMode: false,
  );
}
