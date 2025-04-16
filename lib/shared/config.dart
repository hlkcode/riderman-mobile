import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/login_page.dart';
import '../views/signup_page.dart';
import '../views/verification_page.dart';
import '../views/welcome_page.dart';
import 'common.dart';
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

bool get isUserOnboarded => storage.read(Constants.USER_ONBOARDED) ?? false;

String makeApiUrl(String path) {
  var baseUrl = Constants.BASE_API.endsWith('/')
      ? Constants.BASE_API
      : '${Constants.BASE_API}/';

  return '$baseUrl$path';
}

//todo https://app.quicktype.io/
List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
  GetPage(
    name: WelcomePage.routeName,
    page: () => WelcomePage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: SignUpPage.routeName,
    page: () => SignUpPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: LoginPage.routeName,
    page: () => LoginPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: VerificationPage.routeName,
    page: () => VerificationPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
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
  static final ThemeData lightTheme =
      ThemeData.light().copyWith(primaryColor: kPurpleColor);

  static final ThemeData darkTheme = ThemeData.dark().copyWith();
}
