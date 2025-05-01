import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:get/get.dart';

import '../models/core_models.dart';
import '../shared/config.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();
  String get _accountUrl => makeApiUrl('accounts');
  String get _guardiansUrl => makeApiUrl('Guardians');

  final RxList<Company> companies = [
    Company(id: 1, email: 'email.com', isActive: true, name: 'CompanyName'),
    Company(
        id: 2,
        email: '233265336549@riderman.com',
        isActive: true,
        name: '233265336549'),
    Company(
        id: 3,
        email: 'hlkcode@gmail.com',
        isActive: false,
        name: 'Axon Limited'),
    Company(
        id: 4,
        email: 'halik@gmail.com',
        isActive: false,
        name: 'Light Company'),
  ].obs;

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
}
