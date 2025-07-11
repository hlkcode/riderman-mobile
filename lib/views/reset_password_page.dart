import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/views/login_page.dart';

import '../controllers/auth_controller.dart';
import '../shared/constants.dart';

class ResetPasswordPage extends StatelessWidget {
  static const String routeName = '/ResetPasswordPage';
  ResetPasswordPage({super.key, required this.code, required this.phoneNumber});

  final String code;
  final String phoneNumber;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _password2Ctrl = TextEditingController();
  final AuthController authController = Get.find();
  final RxBool obscurePassword = true.obs;

  InputDecoration passDecoration(String label) => InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(0.08),
            Obx(() => TextFormField(
                  obscureText: obscurePassword.value,
                  decoration: passDecoration('New Password'),
                  validator: requiredValidator,
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                ).marginAll(16)),
            Obx(() => TextFormField(
                  obscureText: obscurePassword.value,
                  decoration: passDecoration('Confirm New Password'),
                  validator: (value) =>
                      getBoolean(GetUtils.isNullOrBlank(value))
                          ? 'Enter password again'
                          : value == _passwordCtrl.text
                              ? null
                              : 'Password Mismatch',
                  controller: _password2Ctrl,
                  keyboardType: TextInputType.visiblePassword,
                ).marginAll(16)),
            verticalSpace(0.04),
            Obx(
              () => LoadingButton(
                // buttonHeight: getHeight(0.06),
                text: 'Proceed',
                isLoading: authController.loading.value,
                buttonColor: kPurpleColor,
                style: kWhiteTextStyle,
                buttonRadius: 12,
                onTapped: () async {
                  var isGood = await authController.resetPassword(
                      phoneNumber, code, _passwordCtrl.text);
                  if (isGood == false) return;
                  Get.offAllNamed(LoginPage.routeName);
                },
              ),
            ),
            verticalSpace(0.02),
          ],
        ),
      ).marginSymmetric(horizontal: 16),
    );
  }
}
