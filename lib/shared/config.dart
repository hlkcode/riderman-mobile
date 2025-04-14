import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

// dynamic get user => GetStorage().read('user');
// int get timeZoneOffset => DateTime.now().toLocal().timeZoneOffset.inHours;
//
// const numberPerPage = 10;

// dynamic get userData => GetStorage().read(Constants.USER_DATA);
// Map<String, String> get headers {
//   final uData = GetStorage().read(Constants.USER_DATA);
//   final token = uData[Constants.TOKEN_KEY];
//   // logInfo('token = $token');
//   return getHeaders(token ?? '');
// }

// bool isLoggedIn() {
//   final String token =
//       GetStorage().hasData('user') ? user[Constants.TOKEN_KEY] : '';
//   return !GetUtils.isNullOrBlank(token)! && !JwtDecoder.isExpired(token);
// }

String makeApiUrl(String path) {
  var baseUrl = Constants.BASE_API.endsWith('/')
      ? Constants.BASE_API
      : '${Constants.BASE_API}/';

  return '$baseUrl$path';
}

//todo https://app.quicktype.io/
List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
  // GetPage(
  //   name: LoginPage.routeName,
  //   page: () => LoginPage(),
  //   transition: Transition.topLevel,
  //   transitionDuration: const Duration(milliseconds: 300),
  //   curve: Curves.easeInOut,
  // ),
  //
  // GetPage(
  //   name: HomePage.routeName,
  //   page: () => isLoggedIn() ? HomePage() : LoginPage(),
  //   transition: Transition.topLevel,
  //   transitionDuration: const Duration(milliseconds: 300),
  //   curve: Curves.easeInOut,
  // ),
];

class Themes {
  static final ThemeData lightTheme = ThemeData.light().copyWith();

  static final ThemeData darkTheme = ThemeData.dark().copyWith();
}
