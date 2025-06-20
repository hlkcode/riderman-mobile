import 'dart:convert';

import 'package:flutter_tools/common.dart';
import 'package:flutter_tools/tools_models.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/common.dart';
import 'package:riderman/shared/config.dart';

import '../models/dto_models.dart';
import '../shared/constants.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';
import '../views/verification_page.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();

  String get _accountUrl => makeApiUrl('companies/users');

  UserCreateDto? _createDto;

  // 1 => sign up // request code // verify // login

  // 2 => login if not verified => request code (resend = true), verify

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> signUp(UserCreateDto dto) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/create';
      final calRes = await _requestManager.sendPostRequest(url, dto.toMap());
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);
      if (res.isSuccess) {
        HlkDialog.showSuccessSnackBar(
            res.message ?? 'Account created successfully');
        _createDto = dto;
        getCode(dto.phoneNumber);
      } else {
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> getCode(String phoneNumber) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/code';
      final calRes = await _requestManager.sendPostRequest(
          url, jsonEncode({'phoneNumber': phoneNumber}));

      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (!res.isSuccess) {
        HlkDialog.showErrorSnackBar(res.message ?? 'Otp Request failed');
      } else {
        Get.toNamed(VerificationPage.routeName);
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> verify(String phoneNumber, String code) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/verify';
      final calRes = await _requestManager.sendPostRequest(
        url,
        jsonEncode({'phoneNumber': phoneNumber, 'code': code}),
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        HlkDialog.showSuccessSnackBar(
            res.message ?? 'Account verified successfully');
        if (getBoolean(_createDto?.canLogin)) {
          await login(phoneNumber, _createDto!.password, _createDto!.profile);
        } else {
          Get.offAllNamed(LoginPage.routeName);
        }
      } else {
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> login(
      String phoneNumber, String password, String profile) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/login';
      final calRes = await _requestManager.sendPostRequest(
        url,
        jsonEncode({
          "phoneNumber": phoneNumber,
          "password": password,
          "profile": profile
        }),
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        // UserData userData = UserData.fromMap(res.data);
        await storage.write(AppConstants.USER_DATA, res.data);
        HlkDialog.showSuccessSnackBar(res.message ?? 'Login successfully');
        // ensure user doesn't see onboarding screen on next startup
        storage.write(AppConstants.USER_ONBOARDED, true);
        Get.offAllNamed(MainPage.routeName);
      } else {
        if (res.message?.containsIgnoreCase('verif') ?? false) {
          // account not verified
          getCode(phoneNumber);
          Get.toNamed(VerificationPage.routeName);
        }
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      logInfo(e);
      handleException(e, null, true);
      if (e.toString().containsIgnoreCase('verif')) {
        // account not verified
        getCode(phoneNumber);
        Get.toNamed(VerificationPage.routeName);
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      loading.value = true;
      var userId = isOwner ? currentUser.ownerId : currentUser.riderId;
      final url = '$_accountUrl/change-password/$userId';
      final calRes = await _requestManager.sendPostRequest(url,
          jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}),
          headers: {
            'Authorization': 'Bearer ${userData?.token}'
                .replaceAll("Bearer Bearer", "Bearer")
          });
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        HlkDialog.showSuccessSnackBar(
            res.message ?? 'Password change successfully');
        Get.offAllNamed(LoginPage.routeName);
      } else {
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> resetPassword(
      String phoneNumber, String code, String password) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/reset-password';
      final calRes = await _requestManager.sendPostRequest(
        url,
        jsonEncode(
            {'phoneNumber': phoneNumber, 'code': code, 'password': password}),
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        HlkDialog.showSuccessSnackBar(
            res.message ?? 'Password reset successfully');
        Get.offAllNamed(LoginPage.routeName);
      } else {
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }
}
