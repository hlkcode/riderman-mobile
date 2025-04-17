import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../shared/common.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import '../views/signup_page.dart';
import '../views/verification_page.dart';
import '../views/welcome_page.dart';
import '../widgets/dropdown_selector.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/LoginPage';
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxString role = ''.obs;
  final options1 = ['Owner', 'Rider'];

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
            TextFormField(
              decoration: getInputDecoration('Phone Number'),
              validator: phoneNumberValidator,
              controller: _phoneNumberCtrl,
              keyboardType: TextInputType.phone,
            ).marginSymmetric(horizontal: 16),
            verticalSpace(0.04),
            Obx(
              () => TextFormField(
                obscureText: obscurePassword.value,
                decoration: passDecoration('Password'),
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
                role.value = getString(newVal);
              },
            ).marginSymmetric(horizontal: 16),
            verticalSpace(0.1),
            LoadingButton(
              // buttonHeight: getHeight(0.06),
              text: 'Login',
              isLoading: false,
              buttonColor: kPurpleColor,
              style: kWhiteTextStyle,
              buttonRadius: 12,
              onTapped: () {},
            ),
            verticalSpace(0.02),
            TextButton(
              onPressed: () {
                var isPhoneValid =
                    phoneNumberValidator(_phoneNumberCtrl.text) == null;
                if (!isPhoneValid) {
                  HlkDialog.showSnackBar(
                    title: 'Attention',
                    message: 'Please enter a valid phone number',
                    color: kPurpleLightColor,
                  );
                  return;
                }
                // todo: send request for verification code to number but do not await it

                Get.toNamed(VerificationPage.routeName);
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
