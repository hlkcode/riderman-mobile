import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';
import 'package:riderman/widgets/dropdown_selector.dart';

import '../shared/common.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/SignUpPage';
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController _surnameCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _password2Ctrl = TextEditingController();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _companyCtrl = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool showCompanyOptions = false.obs;
  final RxBool isCompany = false.obs;
  final RxString role = ''.obs;
  // final RxBool obscureConfirmPassword = true.obs;
  final options1 = ['Owner', 'Rider'];
  final options2 = ['Company', 'Individual'];

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
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: getInputDecoration('Full name'),
                validator: requiredValidator,
                controller: _surnameCtrl,
                keyboardType: TextInputType.name,
              ).paddingAll(10),
              TextFormField(
                decoration: getInputDecoration('Phone Number'),
                validator: requiredValidator,
                controller: _phoneNumberCtrl,
                keyboardType: TextInputType.phone,
              ).paddingAll(10),
              Obx(() => TextFormField(
                    obscureText: obscurePassword.value,
                    decoration: passDecoration('Password'),
                    validator: requiredValidator,
                    controller: _passwordCtrl,
                    keyboardType: TextInputType.visiblePassword,
                  ).paddingAll(10)),
              Obx(() => TextFormField(
                    obscureText: obscurePassword.value,
                    decoration: passDecoration('Confirm Password'),
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
                  role.value = getString(newVal);
                  showCompanyOptions.value =
                      role.value.containsIgnoreCase('owner');
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
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Company Information',
        subtitle: 'Please fill these company information ',
        content: Form(
          key: _formKey2,
          child: Column(
            children: [
              TextFormField(
                decoration: getInputDecoration('Company Name'),
                validator: requiredValidator,
                controller: _companyCtrl,
                keyboardType: TextInputType.name,
              ).paddingAll(10),
              TextFormField(
                decoration: getInputDecoration('Email Address'),
                validator: emailValidator,
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ).paddingAll(10),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Steps completed!');
      },
      steps: steps,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }
}
