import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:get/get.dart';

import '../shared/constants.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();

  String get _accountUrl => makeApiUrl('accounts');
  String get _guardiansUrl => makeApiUrl('Guardians');

  // 1 => sign up // request code // verify // login

  // 2 => login if not verified => request code (resend = true), verify

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
