import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/auth_controller.dart';
import '../shared/common.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import '../views/signup_page.dart';
import '../views/welcome_page.dart';
import '../widgets/dropdown_selector.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/LoginPage';
  LoginPage({super.key});

  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final options1 = ['Owner', 'Rider'];

  @override
  Widget build(BuildContext context) {
    String role = '', phoneNumber = '';
    //
    return Scaffold(
      appBar: AppBar(
        leading: isUserOnboarded == false
            ? IconButton(
                onPressed: () => Get.offAllNamed(WelcomePage.routeName),
                icon: Icon(Icons.arrow_back_outlined))
            : null,
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(0.08),
            IntlPhoneField(
              controller: _phoneNumberCtrl,
              countries: allowedCountries,
              // validator: (phone) =>
              //     zPhoneNumberValidator(phone?.completeNumber),
              decoration: getInputDecoration('Phone Number'),
              initialCountryCode: 'GH',
              onChanged: (phone) {
                logInfo(phone.completeNumber);
                phoneNumber = phone.completeNumber.replaceAll('+', '').trim();
              },
            ).marginSymmetric(horizontal: 16),
            verticalSpace(0.04),
            Obx(
              () => TextFormField(
                obscureText: obscurePassword.value,
                decoration: passDecoration('Password', obscurePassword),
                validator: requiredValidator,
                controller: _passwordCtrl,
                keyboardType: TextInputType.visiblePassword,
              ).marginSymmetric(horizontal: 16),
            ),
            verticalSpace(0.04),
            DropDownSelector(
              list: options1,
              instruction: 'Select Profile',
              onSelectionChange: (newVal) {
                role = getString(newVal).toLowerCase();
              },
            ).marginSymmetric(horizontal: 16),
            verticalSpace(0.1),
            Obx(
              () => LoadingButton(
                // buttonHeight: getHeight(0.06),
                text: 'Login',
                isLoading: authController.loading.value,
                buttonColor: kPurpleColor,
                style: kWhiteTextStyle,
                buttonRadius: 12,
                onTapped: () async {
                  var isGood = getBoolean(_formKey.currentState?.validate());

                  var password = _passwordCtrl.text.trim();

                  if (zPhoneNumberValidator(phoneNumber) != null) {
                    HlkDialog.showErrorSnackBar('Invalid phone number');
                    return;
                  }

                  if (password.isEmpty) {
                    HlkDialog.showErrorSnackBar('Password is required');
                    return;
                  }

                  if (role.isEmpty) {
                    HlkDialog.showErrorSnackBar('Please select profile');
                    return;
                  }

                  await authController.login(phoneNumber, password, role);
                },
              ),
            ),
            verticalSpace(0.02),
            TextButton(
              onPressed: () {
                var isPhoneValid =
                    zPhoneNumberValidator(_phoneNumberCtrl.text) == null;
                if (!isPhoneValid) {
                  HlkDialog.showSnackBar(
                    message: 'Please enter a valid phone number',
                    color: kPurpleLightColor,
                  );
                  return;
                }
                // todo: send request for verification code to number but do not await it
                authController.getCode(phoneNumber);
                // Get.toNamed(VerificationPage.routeName);
                // Get.to(() =>
                //     VerificationPage(nextPage: ResetPasswordPage.routeName));
              },
              child: Text(
                'Forget Password ?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPurpleColor,
                    fontSize: 16),
              ),
            ),
            verticalSpace(0.02),
            GestureDetector(
              onTap: () => Get.toNamed(SignUpPage.routeName),
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(fontSize: 16),
                  children: [
                    TextSpan(text: 'Don\'t have an account yet? '),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPurpleColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).marginSymmetric(horizontal: 16),
    );
  }
}
