import 'package:flutter/material.dart';
import 'package:flutter_tools/common.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

import '../models/core_models.dart';
import '../views/companies_page.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';
import '../views/new_asset_page.dart';
import '../views/signup_page.dart';
import '../views/welcome_page.dart';
import 'constants.dart';

UserData get currentUserData => UserData.fromMap(userData);

User get currentUser => User.fromMap(currentUserData.user.toMap());

Company get currentCompany =>
    Company.fromMap(storage.read(AppConstants.COMPANY_DATA));

bool get isUserOnboarded => storage.read(AppConstants.USER_ONBOARDED) ?? false;

bool get isCompanySet => storage.hasData(AppConstants.COMPANY_DATA);

String makeApiUrl(String path) {
  var baseUrl = AppConstants.BASE_API.endsWith('/')
      ? AppConstants.BASE_API
      : '${AppConstants.BASE_API}/';

  return '$baseUrl$path';
}

List<Country> get allowedCountries => countries
    .where((c) => AppConstants.allowCountryCodes.contains(c.code))
    .toList();

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
  // GetPage(
  //   name: ResetPasswordPage.routeName,
  //   page: () => ResetPasswordPage(),
  //   transition: Transition.topLevel,
  //   transitionDuration: const Duration(milliseconds: 300),
  //   curve: Curves.easeInOut,
  // ),
  GetPage(
    name: NewAssetPage.routeName,
    page: () => isLoggedIn() ? NewAssetPage() : LoginPage(),
    transition: Transition.topLevel,
    transitionDuration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  // GetPage(
  //   name: NewAssetPage.routeName,
  //   page: () => isLoggedIn() ? NewAssetPage() : LoginPage(),
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
