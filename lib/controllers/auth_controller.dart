import 'dart:async';
import 'dart:convert';

import 'package:flutter_tools/common.dart';
import 'package:flutter_tools/tools_models.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/config.dart';

import '../data/db_manager.dart';
import '../models/dto_models.dart';
import '../shared/common.dart';
import '../shared/constants.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';
import '../views/verification_page.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();

  String get _accountUrl => makeApiUrl('companies/users');

  String _phoneNumber = '', _password = '', _profile = '';

  bool get canTempUserLogin =>
      _phoneNumber.isNotEmpty && _password.isNotEmpty && _profile.isNotEmpty;

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
      final calRes = await _requestManager.sendPostRequest(
        url,
        dto.toMap(),
        returnBodyOnError: true,
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);
      if (res.isSuccess) {
        showSuccessMessage(res.message ?? 'Account created successfully');
        _phoneNumber = dto.phoneNumber;
        _password = dto.password;
        _profile = dto.profile;

        getCode(dto.phoneNumber);
        // when successful, auto login and go to main page
        Get.to(() => VerificationPage(
            phoneNumber: _phoneNumber, nextPage: MainPage.routeName));
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
        url,
        jsonEncode({'phoneNumber': phoneNumber}),
        returnBodyOnError: true,
      );

      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      var mes = res.message ??
          (res.isSuccess ? 'Code sent successfully' : 'Code Request failed');

      if (!res.isSuccess) {
        HlkDialog.showErrorSnackBar(mes);
        return;
      }
      showSuccessMessage(mes);
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
  }

  Future<void> autoLogin(Function()? onSuccess) async =>
      await login(_phoneNumber, _password, _profile, onSuccess);

  Future<bool> verify(String phoneNumber, String code) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/verify';
      final calRes = await _requestManager.sendPostRequest(
        url,
        jsonEncode({'phoneNumber': phoneNumber, 'code': code}),
        returnBodyOnError: true,
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);
      var mes = res.message ??
          (res.isSuccess
              ? 'Code verified successfully'
              : 'Verification failed');
      if (!res.isSuccess) {
        HlkDialog.showErrorSnackBar(mes);
        return false;
      }
      showSuccessMessage(mes);
      return true;
      // if (res.isSuccess) {
      //   HlkDialog.showSuccessSnackBar(
      //       res.message ?? 'Account verified successfully');
      //   if (canTempUserLogin) {
      //     await login(phoneNumber, _password, _profile);
      //   } else {
      //     Get.offAllNamed(LoginPage.routeName);
      //   }
      //   return true;
      // } else {
      //   HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      // }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
    return false;
  }

  Future<void> login(String phoneNumber, String password, String profile,
      Function()? onSuccess) async {
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
        returnBodyOnError: true,
      );
      logInfo('res => $calRes');
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);
      _phoneNumber = phoneNumber;
      _password = password;
      _profile = profile;
      if (!res.isSuccess) {
        if (res.message?.containsIgnoreCase('verif') ?? false) {
          // account not verified
          getCode(phoneNumber);
          Get.to(() => VerificationPage(
              phoneNumber: phoneNumber, nextPage: MainPage.routeName));
          // Get.toNamed(VerificationPage.routeName);
        }
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
        return;
      }
      // make sure to have fresh db for newly login in user to avoid inconsistencies
      // in the data as profile or user might have changed
      await DBManager.clearAllTables();
      // UserData userData = UserData.fromMap(res.data);
      await storage.write(Constants.USER_DATA, res.data);
      //
      showSuccessMessage(res.message ?? 'Login successfully');
      // ensure user doesn't see onboarding screen on next startup
      await storage.write(AppConstants.USER_ONBOARDED, true);
      await storage.save();
      if (onSuccess != null) onSuccess();
      // Get.offAllNamed(MainPage.routeName);
      goToMainPage();
    } catch (e) {
      logInfo(e);
      handleException(e, null, true);
      if (e.toString().containsIgnoreCase('verif')) {
        // account not verified
        getCode(phoneNumber);
        Get.to(() => VerificationPage(
            phoneNumber: phoneNumber, nextPage: MainPage.routeName));
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      loading.value = true;
      var userId =
          currentUser.isOwner ? currentUser.ownerId : currentUser.riderId;
      final url = '$_accountUrl/change-password/$userId';
      final calRes = await _requestManager.sendPostRequest(url,
          jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword}),
          returnBodyOnError: true,
          headers: {
            'Authorization': 'Bearer ${userData?.token}'
                .replaceAll("Bearer Bearer", "Bearer")
          });
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        showSuccessMessage(res.message ?? 'Password change successfully');
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

  Future<bool> resetPassword(
      String phoneNumber, String code, String password) async {
    try {
      loading.value = true;
      final url = '$_accountUrl/reset-password';
      final calRes = await _requestManager.sendPostRequest(
        returnBodyOnError: true,
        url,
        jsonEncode(
            {'phoneNumber': phoneNumber, 'code': code, 'password': password}),
      );
      logInfo(calRes);
      final BaseResponse res =
          BaseResponse.fromMap(calRes as Map<String, dynamic>);

      if (res.isSuccess) {
        showSuccessMessage(res.message ?? 'Password reset successfully');
        Get.offAllNamed(LoginPage.routeName);
        return true;
      } else {
        HlkDialog.showErrorSnackBar(res.message ?? 'Please retry shortly');
      }
    } catch (e) {
      handleException(e, null, true);
    } finally {
      loading.value = false;
    }
    return false;
  }
}
