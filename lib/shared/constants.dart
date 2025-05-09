import 'package:flutter/material.dart';

const Color kErrorColor = Color(0xCCDC3232);
const Color kSuccessColor = Color(0xFF78E000);
const Color kPurpleColor = Color(0xFF6A2055);
const Color kPurpleLightColor = Color(0xFFEACEDD);
const kWhiteTextStyle = TextStyle(color: Colors.white, fontSize: 16);
const kPurpleTextStyle = TextStyle(color: kPurpleColor, fontSize: 16);
const kBlackTextStyle = TextStyle(color: Colors.black, fontSize: 16);

String makeApiUrl(String path) => '${AppConstants.BASE_API}$path';

class AppConstants {
  static const String APP_NAME = 'RiderMan'; // TODO SET VALUE
  static const String APP_PACKAGE = 'com.zerolafrica.riderman';
  static const String BASE_API =
      'https://test.riderman.zerolafrica.com/api/v1/';
  // static const String BASE_API = 'https://riderman.zerolafrica.com/api/v1';

  static const String ICON_CAR_ROUND = 'assets/images/Car icon.png';
  static const String ICON_CAR = 'assets/images/Just the car.png';
  static const String ICON_BIKE = 'assets/images/Just motorbike.png';
  static const String ICON_BIKE_ROUND = 'assets/images/Motor icon.png';
  static const String ICON_RIDE_COUNT = 'assets/images/Number of rides.png';
  static const String ICON_TRICYCLE = 'assets/images/Just tricycle.png';
  static const String ICON_TRICYCLE_ROUND = 'assets/images/Tricycle icon.png';
  static const String ICON_TRUCK = 'assets/images/Truck icon.png';
  static const String ICON_TRUCK_ROUND = 'assets/images/Truck in circle.png';
  static const String ICON_TR_COUNT = 'assets/images/Amount made.png';

  static const String TOKEN_KEY = 'token';
  static const String USER_DATA = 'userData';
  static const String COMPANY_DATA = 'companyData';

  static const String USER_ONBOARDED = 'userOnboarded';
}
