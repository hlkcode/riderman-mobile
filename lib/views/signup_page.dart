import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:riderman/models/dto_models.dart';

import '../controllers/auth_controller.dart';
import '../shared/common.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import '../views/login_page.dart';
import '../views/welcome_page.dart';
import '../widgets/company_form.dart';
import '../widgets/dropdown_selector.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/SignUpPage';
  SignUpPage({super.key});

  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController _surnameCtrl = TextEditingController();
  final TextEditingController _otherNamesCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _password2Ctrl = TextEditingController();
  //
  final TextEditingController _companyNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool showCompanyOptions = false.obs;
  final RxBool isCompany = false.obs;

  final options1 = ['Owner', 'Rider'];
  final options2 = ['Company', 'Individual'];

  @override
  Widget build(BuildContext context) {
    String role = '', phoneNumber = '';
    //
    final userStep = CoolStep(
      title: 'Basic Information',
      subtitle: 'Please fill some of the basic information to get started',
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _surnameCtrl,
              // onChanged: (text) => createDto.surname = text.trim(),
              decoration: getInputDecoration('Surname'),
              validator: requiredValidator,
              keyboardType: TextInputType.name,
            ).paddingAll(10),
            TextFormField(
              controller: _otherNamesCtrl,
              // onChanged: (text) => createDto.otherNames = text.trim(),
              decoration: getInputDecoration('Other names'),
              validator: requiredValidator,
              keyboardType: TextInputType.name,
            ).paddingAll(10),
            IntlPhoneField(
              controller: _phoneNumberCtrl,
              countries: allowedCountries,
              // validator: (phone) =>
              //     zPhoneNumberValidator(phone?.completeNumber),
              decoration: getInputDecoration('Phone Number'),
              // autovalidateMode: AutovalidateMode.onUnfocus,
              initialCountryCode: 'GH',
              onChanged: (phone) {
                logInfo(phone.completeNumber);
                phoneNumber = phone.completeNumber.replaceAll('+', '').trim();
              },
            ).paddingAll(10),
            // TextFormField(
            //   decoration: getInputDecoration('Phone Number'),
            //   validator: phoneNumberValidator,
            //   controller: _phoneNumberCtrl,
            //   keyboardType: TextInputType.phone,
            // ).paddingAll(10),
            Obx(() => TextFormField(
                  // onChanged: (text) => createDto.password = text.trim(),
                  obscureText: obscurePassword.value,
                  decoration: passDecoration('Password', obscurePassword),
                  validator: requiredValidator,
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                ).paddingAll(10)),
            Obx(() => TextFormField(
                  // onChanged: (text) => createDto.password = text.trim(),
                  obscureText: obscurePassword.value,
                  decoration:
                      passDecoration('Confirm Password', obscurePassword),
                  validator: (value) =>
                      getBoolean(GetUtils.isNullOrBlank(value))
                          ? 'Enter password again'
                          : value == _passwordCtrl.text
                              ? null
                              : 'Password Mismatch',
                  controller: _password2Ctrl,
                  keyboardType: TextInputType.visiblePassword,
                ).paddingAll(10)),
            DropDownSelector(
              list: options1,
              instruction: 'Select Profile',
              onSelectionChange: (newVal) {
                role = getString(newVal).toLowerCase();
                showCompanyOptions.value = role.containsIgnoreCase('owner');
              },
            ).paddingAll(10),
            Obx(() => showCompanyOptions.value
                ? DropDownSelector(
                    list: options2,
                    instruction: 'Sign up as',
                    onSelectionChange: (newVal) => isCompany.value =
                        getString(newVal).containsIgnoreCase('company'),
                  ).paddingAll(10)
                : SizedBox.shrink()),
          ],
        ),
      ),
      validation: () {
        if (!getBoolean(_formKey.currentState?.validate())) {
          return 'Fill basic information correctly';
        }
        _formKey.currentState?.save();
        return null;
      },
    );

    final companyStep = CoolStep(
      title: 'Company Information',
      subtitle: 'Please fill these company information',
      content: CompanyForm(
        formKey: _formKey2,
        companyNameCtrl: _companyNameCtrl,
        emailCtrl: _emailCtrl,
      ),
      validation: () {
        if (!getBoolean(_formKey2.currentState?.validate())) {
          return 'Fill company information correctly';
        }
        _formKey2.currentState?.save();
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (isUserOnboarded) {
                Get.offNamed(LoginPage.routeName);
              } else {
                Get.offNamed(WelcomePage.routeName);
              }
            },
            icon: Icon(Icons.arrow_back_outlined)),
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() => CoolStepper(
              // showErrorSnackbar: true,
              onCompleted: () {
                logInfo('hlk => Steps completed!');
                _formKey.currentState?.save();
                _formKey2.currentState?.save();
              },
              steps: [userStep, if (isCompany.value) companyStep],
              config: CoolStepperConfig(
                backText: 'BACK',
                finalText: 'SIGN-UP',
                nextTextColor: kPurpleColor,
                lastTextColor: kPurpleLightColor,
              ),
              finishButton: SizedBox(
                width: getWidth(0.3),
                child: Obx(
                  () => LoadingButton(
                    text: 'Sign Up',
                    isLoading: authController.loading.value,
                    buttonColor: kPurpleColor,
                    style: kWhiteTextStyle,
                    buttonRadius: 12,
                    onTapped: () async {
                      var isGood = isCompany.value
                          ? getBoolean(_formKey.currentState?.validate()) &&
                              getBoolean(_formKey2.currentState?.validate())
                          : getBoolean(_formKey.currentState?.validate());

                      var email = _emailCtrl.text.trim().isEmpty
                          ? null
                          : _emailCtrl.text.trim();
                      var createDto = UserCreateDto(
                        phoneNumber: phoneNumber,
                        surname: _surnameCtrl.text.trim(),
                        otherNames: _otherNamesCtrl.text.trim(),
                        password: _passwordCtrl.text.trim(),
                        email: email,
                        promoCode: null,
                        companyName: _companyNameCtrl.text.trim(),
                        profile: role,
                        isCompany: isCompany.value,
                      );

                      if (createDto.surname.isEmpty) {
                        HlkDialog.showErrorSnackBar('Surname is required');
                        return;
                      }

                      if (createDto.otherNames.isEmpty) {
                        HlkDialog.showErrorSnackBar('Other names is required');
                        return;
                      }

                      if (createDto.password.isEmpty) {
                        HlkDialog.showErrorSnackBar('Password is required');
                        return;
                      }

                      if (_passwordCtrl.text.trim() !=
                          _password2Ctrl.text.trim()) {
                        HlkDialog.showErrorSnackBar('Password mismatch');
                        return;
                      }

                      if (createDto.profile.isEmpty) {
                        HlkDialog.showErrorSnackBar('Please select profile');
                        return;
                      }

                      if (isCompany.isTrue &&
                          getBoolean(GetUtils.isNullOrBlank(createDto.email))) {
                        HlkDialog.showErrorSnackBar(
                            'Email is required for company');
                        return;
                      }

                      if (isCompany.isTrue && createDto.companyName.isEmpty) {
                        HlkDialog.showErrorSnackBar('Company name is required');
                        return;
                      }

                      logInfo(createDto.toMap());
                      await authController.signUp(createDto);
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
