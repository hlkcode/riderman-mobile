import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../shared/common.dart';

class CompanyForm extends StatelessWidget {
  CompanyForm({super.key, required this.formKey});

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _companyCtrl = TextEditingController();
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
    );
  }
}
