import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';
import 'package:riderman/widgets/company_form.dart';
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
    final userStep = CoolStep(
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
              validator: phoneNumberValidator,
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
    );

    final companyStep = CoolStep(
      title: 'Company Information',
      subtitle: 'Please fill these company information',
      content: CompanyForm(formKey: _formKey2),
      validation: () {
        if (!_formKey2.currentState!.validate()) {
          return 'Fill form correctly';
        }
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined),
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() => CoolStepper(
              showErrorSnackbar: false,
              onCompleted: () {
                //print('Steps completed!');
              },
              steps: isCompany.value ? [userStep, companyStep] : [userStep],
              config: CoolStepperConfig(
                backText: 'BACK',
                finalText: 'SIGN UP',
                nextTextColor: kPurpleColor,
                lastTextColor: kPurpleLightColor,
              ),
              finishButton: SizedBox(
                width: getWidth(0.3),
                child: LoadingButton(
                  // buttonHeight: getHeight(0.06),
                  text: 'Sign Up',
                  isLoading: false,
                  buttonColor: kPurpleColor,
                  style: const TextStyle(color: Colors.white),
                  buttonRadius: 12,
                  onTapped: () {},
                ),
              ),
            )),
      ),
    );
  }
}
