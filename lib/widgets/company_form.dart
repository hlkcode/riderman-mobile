import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../shared/common.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm(
      {super.key,
      required this.formKey,
      required this.companyNameCtrl,
      required this.emailCtrl});

  final GlobalKey<FormState> formKey;
  final TextEditingController companyNameCtrl;
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: companyNameCtrl,
            decoration: getInputDecoration('Company Name'),
            validator: requiredValidator,
            keyboardType: TextInputType.name,
          ).paddingAll(10),
          TextFormField(
            controller: emailCtrl,
            decoration: getInputDecoration('Email Address'),
            validator: emailValidator,
            keyboardType: TextInputType.emailAddress,
          ).paddingAll(10),
        ],
      ),
    );
  }
}
