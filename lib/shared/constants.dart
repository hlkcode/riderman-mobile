import 'package:flutter/material.dart';

const Color kErrorColor = Color(0xCCDC3232);
const Color kSuccessColor = Color(0xFF78E000);
const Color kPurpleColor = Color(0xFF6A2055);
const Color kPurpleLightColor = Color(0xFFEACEDD);

String makeApiUrl(String path) => '${Constants.BASE_API}$path';

class Constants {
  static const String APP_NAME = 'RiderMan'; // TODO SET VALUE
  static const String APP_PACKAGE = 'com.zerolafrica.riderman';
  static const String BASE_API =
      'https://test.riderman.zerolafrica.com/api/v1/';
  // static const String BASE_API = 'https://riderman.zerolafrica.com/api/v1';

  static const String TOKEN_KEY = 'token';
  static const String USER_DATA = 'userData';

  static const String USER_ONBOARDED = 'userOnboarded';
}
