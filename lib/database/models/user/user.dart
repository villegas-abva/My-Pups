class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User(
      {required this.name,
      required this.about,
      required this.email,
      required this.imagePath,
      required this.isDarkMode});
}
