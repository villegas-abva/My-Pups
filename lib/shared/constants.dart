// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class AppImages {
  static const String images = 'assets/images/';
  static String _image(String key,
          {String prefix = images, String ext = 'png'}) =>
      '$prefix/$key.$ext';

  static final String luna_image = _image('lunita');

  static final String marito_image = _image('marito');

  static final String juanito_image = _image('juanito');
}

abstract class AppTextStyles {
  static const RedHat = TextStyle(
      fontFamily: 'RedHat', fontSize: 30, fontWeight: FontWeight.w600);
  static const Dongle = TextStyle(
      fontFamily: 'Dongle', fontSize: 30, fontWeight: FontWeight.w400);
}
