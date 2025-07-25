import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:riderman/shared/config.dart';
import 'package:riderman/views/companies_page.dart';
import 'package:riderman/views/main_page.dart';

import '../models/core_models.dart';
import '../views/identification_page.dart';
import 'constants.dart';

Map<String, String> guarantorEntry(
        String fullName, String phoneNumber, String photoPath) =>
    {"fullName": fullName, "phoneNumber": phoneNumber, "photo": photoPath};

bool isPropPending(Property? prop) =>
    prop != null &&
    (prop.propertyStatus.toLowerCase() ==
            PropertyStatus.CONNECTING.name.toLowerCase() ||
        prop.propertyStatus.toLowerCase() ==
            PropertyStatus.VERIFYING.name.toLowerCase());

bool isVerifying(Property? prop) =>
    prop != null &&
    prop.propertyStatus.toLowerCase() ==
        PropertyStatus.VERIFYING.name.toLowerCase();

void goToMainPage() {
  if (currentUser.isRider && currentUser.isIdCardInvalid) {
    Get.offAll(() => IdentificationPage());
  } else {
    if (isCompanySet) {
      Get.offAllNamed(MainPage.routeName);
    } else {
      Get.offAllNamed(CompaniesPage.routeName);
    }
  }
}

void showSuccessMessage(String message) => HlkDialog.showSnackBar(
    message: message, title: 'Success', color: kPurpleLightColor);

String? zPhoneNumberValidator(String? text) {
  if (!GetUtils.isPhoneNumber(getString(text))) return 'Invalid Phone Number';
  var countryCodes = countries.map((c) => c.dialCode).toList();

  return countryCodes.any((code) => getString(text).startsWith(code))
      ? null
      : 'Unknown country code';
}

InputDecoration passDecoration(String label, RxBool obscurePassword) =>
    InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      suffixIcon: InkWell(
        onTap: () => obscurePassword.toggle(),
        child: Icon(
          obscurePassword.value ? Icons.visibility_off : Icons.visibility,
          color: kPurpleLightColor,
        ),
      ),
    );

InputDecoration getInputDecoration(String hint,
        {bool fill = false, double radius = 6}) =>
    InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
      // hintText: hint,
      labelText: hint,
      filled: fill,
    );

InputDecoration getInputDecorationNoBorder(String hint,
        {bool fill = false, TextStyle? style}) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      hintText: hint,
      hintStyle: style,
      filled: fill,
    );

IconData getPropertyIcon(String typeString) {
  PropertyType type = PropertyType.values.byName(typeString);
  return type == PropertyType.Motorcycle
      ? FontAwesomeIcons.motorcycle
      : type == PropertyType.Tricycle
          ? FontAwesomeIcons.bicycle
          : type == PropertyType.Car
              ? FontAwesomeIcons.car
              : type == PropertyType.Truck
                  ? FontAwesomeIcons.truck
                  : FontAwesomeIcons.tractor;
}

AccountOverview get defaultAccountOverview => AccountOverview(
      companyId: 0,
      totalEarnings: 0,
      totalPropertyCount: 0,
      totalPaidSalesCount: 0,
      availableBalance: 0,
      bikeCount: 0,
      bikeEarnings: 0,
      bikeExpenditures: 0,
      bikeExpendituresCount: 0,
      bikeSalesCount: 0,
      carCount: 0,
      carEarnings: 0,
      carExpenditures: 0,
      carExpendituresCount: 0,
      carSalesCount: 0,
      createdAt: DateTime.now(),
      id: 0,
      totalExpenditures: 0,
      totalExpendituresCount: 0,
      tricycleCount: 0,
      tricycleEarnings: 0,
      tricycleExpenditures: 0,
      tricycleExpendituresCount: 0,
      tricycleSalesCount: 0,
      trucCount: 0,
      trucEarnings: 0,
      trucExpenditures: 0,
      trucExpendituresCount: 0,
      trucSalesCount: 0,
      updatedAt: DateTime.now(),
    );
