import 'package:flutter/material.dart';
import 'package:flutter_tools/common.dart';
import 'package:get/get.dart';

import '../views/companies_page.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';
import '../views/reset_password_page.dart';
import '../views/signup_page.dart';
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

bool get isUserOnboarded => storage.read(AppConstants.USER_ONBOARDED) ?? false;

String makeApiUrl(String path) {
  var baseUrl = AppConstants.BASE_API.endsWith('/')
      ? AppConstants.BASE_API
      : '${AppConstants.BASE_API}/';

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
    name: CompaniesPage.routeName,
    page: () => isLoggedIn() ? CompaniesPage() : LoginPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: MainPage.routeName,
    page: () => isLoggedIn() ? MainPage() : LoginPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  GetPage(
    name: ResetPasswordPage.routeName,
    page: () => ResetPasswordPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  // GetPage(
  //   name: BusinessPage.routeName,
  //   page: () => isLoggedIn() ? BusinessPage() : LoginPage(),
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
