import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../models/core_models.dart';
import '../shared/constants.dart';
import '../widgets/labeled_widgets.dart';

class AssetDetailsPage extends StatelessWidget {
  static const String routeName = '/AssetDetailsPage';

  final Property property;
  AssetDetailsPage({super.key, required this.property});

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<String> nExpectedPayments = '0'.obs;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var contracts =
        ContractType.values.map((e) => e.name.toUpperCase()).toList();
    var assetTypes =
        PropertyType.values.map((e) => e.name.toUpperCase()).toList();
    var frequencies =
        PaymentFrequency.values.map((e) => e.name.toUpperCase()).toList();

    nExpectedPayments.value = property.expectedSalesCount.toString();
    startDate.value = property.startDate;

    return Scaffold(
      // backgroundColor: kPurpleLightColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text(property.plateNumber),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CoolStepper(
          showErrorSnackbar: false,
          onCompleted: () {
            //print('Steps completed!');
          },
          steps: [
            CoolStep(
              title: 'Agreement\'s Basic Information',
              subtitle: 'Please fill these agreement information',
              content: Form(
                key: _formKey,
                child: Column(
                  spacing: getHeight(0.02),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // verticalSpace(0.02),
                    LabeledTextField(
                      title: 'Rider\'s Phone Number',
                      validator: phoneNumberValidator,
                      inputType: TextInputType.phone,
                      controller: TextEditingController(
                          text: property.rider?.phoneNumber),
                    ),
                    LabeledTextField(
                      title: 'Number plate',
                      validator: requiredValidator,
                      inputType: TextInputType.text,
                      controller:
                          TextEditingController(text: property.plateNumber),
                    ),
                    LabeledSelector(
                      selectedIndex: contracts
                          .indexOf(property.contractType.toUpperCase()),
                      title: 'Contract type',
                      options: contracts,
                      instruction: 'Select contract type',
                      onSelectionChange: (newValue) {},
                    ),
                    LabeledSelector(
                      selectedIndex: assetTypes
                          .indexOf(property.propertyType.toUpperCase()),
                      title: 'Type of Asset',
                      options: assetTypes,
                      instruction: 'Select Asset type',
                      onSelectionChange: (newValue) {},
                    ),
                    LabeledTextField(
                      controller: TextEditingController(
                          text: property.guarantorsNeeded.toString()),
                      title: 'Number of Guarantor(s) Required',
                      inputType: TextInputType.number,
                    ),
                    // verticalSpace(0.1),
                  ],
                ).marginSymmetric(horizontal: 12),
              ),
              validation: () {
                if (!_formKey.currentState!.validate()) {
                  return 'Fill form correctly';
                }
                _formKey.currentState!.save();
                return null;
              },
            ),
            CoolStep(
              title: 'Agreement\'s Financial Information',
              subtitle: 'Please fill these financial information',
              content: Form(
                key: _formKey2,
                child: Column(
                  spacing: getHeight(0.02),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // verticalSpace(0.02),
                    LabeledTextField(
                      controller: TextEditingController(
                          text: property.totalExpected.toString()),
                      title: 'Total Expected',
                      validator: (newValue) {
                        var res = requiredValidator(newValue);
                        if (!getBoolean(GetUtils.isNullOrBlank(res))) {
                          return res;
                        }

                        return GetUtils.isNum(getString(newValue))
                            ? null
                            : 'Invalid number detected';
                      },
                      inputType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    LabeledTextField(
                      controller: TextEditingController(
                          text: property.amountAgreed.toString()),
                      title: 'Instalment Amount',
                      validator: (newValue) {
                        var res = requiredValidator(newValue);
                        if (!getBoolean(GetUtils.isNullOrBlank(res))) {
                          return res;
                        }

                        return GetUtils.isNum(getString(newValue))
                            ? null
                            : 'Invalid number detected';
                      },
                      inputType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    LabeledTextField(
                      controller: TextEditingController(
                          text: property.deposit.toString()),
                      title: 'Initial Deposit / Amount Paid Previously',
                      inputType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    LabeledSelector(
                      selectedIndex: frequencies
                          .indexOf(property.paymentFrequency.toUpperCase()),
                      title: 'Payment Frequency',
                      options: frequencies,
                      instruction: 'Select Payment Frequency',
                      onSelectionChange: (newValue) {},
                    ),
                    Obx(
                      () => LabeledTextField(
                        title: 'Number of payments expected',
                        readOnly: true,
                        controller: TextEditingController(
                            text: nExpectedPayments.value),
                      ),
                    ),
                    LabeledWidget(
                      title: 'Business commencement date',
                      widget: GestureDetector(
                        onTap: () async {
                          var now = DateTime.now();
                          var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(2020),
                            lastDate: now.add(Duration(days: 30)),
                          );
                          startDate.value = pickedDate ?? property.startDate;
                        },
                        child: Container(
                          height: getHeight(0.06),
                          decoration: BoxDecoration(
                              border: Border.all(color: kPurpleColor),
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Obx(() => Text(startDate.value.toLongDate())),
                        ),
                      ),
                    ),
                    // verticalSpace(0.02),
                  ],
                ).marginSymmetric(horizontal: 12),
              ),
              validation: () {
                if (!_formKey2.currentState!.validate()) {
                  return 'Fill form correctly';
                }
                _formKey2.currentState!.save();
                return null;
              },
            ),
          ],
          config: CoolStepperConfig(
            backText: 'BACK',
            finalText: 'PROCEED',
            nextTextColor: kPurpleColor,
            lastTextColor: kPurpleLightColor,
          ),
          finishButton: SizedBox(
            width: getWidth(0.3),
            child: LoadingButton(
              // buttonHeight: getHeight(0.06),
              text: 'UPDATE',
              isLoading: false,
              buttonColor: kPurpleColor,
              style: kWhiteTextStyle,
              buttonRadius: 12,
              onTapped: () {
                //
                // check if anything change before allowing the call to go through
              },
            ),
          ),
        ),
      ),
    );
  }
}

// SingleChildScrollView(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Card(
// color: kPurpleLightColor,
// child: ListTile(
// title: Text('Agreement\'s Basic Information'),
// trailing: Icon(Icons.info_outline_rounded),
// ).paddingSymmetric(vertical: 10),
// ).marginSymmetric(horizontal: 10),
// verticalSpace(0.02),
// Form(
// key: _formKey,
// child: Column(
// spacing: getHeight(0.02),
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // verticalSpace(0.02),
// LabeledTextField(
// title: 'Rider\'s Phone Number',
// validator: phoneNumberValidator,
// inputType: TextInputType.phone,
// ),
// LabeledTextField(
// title: 'Number plate',
// validator: requiredValidator,
// inputType: TextInputType.text,
// ),
// LabeledSelector(
// title: 'Contract type',
// options: ContractType.values.map((e) => e.name).toList(),
// instruction: 'Select contract type',
// onSelectionChange: (newValue) {},
// ),
// LabeledSelector(
// title: 'Type of Asset',
// options: PropertyType.values.map((e) => e.name).toList(),
// instruction: 'Select Asset type',
// onSelectionChange: (newValue) {},
// ),
// LabeledTextField(
// title: 'Number of Guarantor(s) Required',
// inputType: TextInputType.number,
// ),
// // verticalSpace(0.1),
// ],
// ),
// ).marginSymmetric(horizontal: 20),
// verticalSpace(0.05),
// Card(
// color: kPurpleLightColor,
// child: ListTile(
// title: Text('Agreement\'s Financial Information'),
// trailing: Icon(Icons.info_outline_rounded),
// ).paddingSymmetric(vertical: 10),
// ).marginSymmetric(horizontal: 10),
// verticalSpace(0.02),
// Form(
// key: _formKey2,
// child: Column(
// spacing: getHeight(0.02),
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // verticalSpace(0.02),
// LabeledTextField(
// title: 'Total Expected',
// validator: (newValue) {
// var res = requiredValidator(newValue);
// if (!getBoolean(GetUtils.isNullOrBlank(res))) {
// return res;
// }
//
// return GetUtils.isNum(getString(newValue))
// ? null
//     : 'Invalid number detected';
// },
// inputType: TextInputType.numberWithOptions(decimal: true),
// ),
// LabeledTextField(
// title: 'Instalment Amount',
// validator: (newValue) {
// var res = requiredValidator(newValue);
// if (!getBoolean(GetUtils.isNullOrBlank(res))) {
// return res;
// }
//
// return GetUtils.isNum(getString(newValue))
// ? null
//     : 'Invalid number detected';
// },
// inputType: TextInputType.numberWithOptions(decimal: true),
// ),
// LabeledTextField(
// title: 'Initial Deposit / Amount Paid Previously',
// inputType: TextInputType.numberWithOptions(decimal: true),
// ),
// LabeledSelector(
// title: 'Payment Frequency',
// options:
// PaymentFrequency.values.map((e) => e.name).toList(),
// instruction: 'Select Payment Frequency',
// onSelectionChange: (newValue) {},
// ),
// Obx(
// () => LabeledTextField(
// title: 'Number of payments expected',
// readOnly: true,
// controller:
// TextEditingController(text: nExpectedPayments.value),
// ),
// ),
// LabeledWidget(
// title: 'Business commencement date',
// widget: GestureDetector(
// onTap: () async {
// var now = DateTime.now();
// var pickedDate = await showDatePicker(
// context: context,
// initialDate: now,
// firstDate: DateTime(2020),
// lastDate: now.add(Duration(days: 30)),
// );
// if (pickedDate != null) startDate.value = pickedDate;
// },
// child: Container(
// height: getHeight(0.06),
// decoration: BoxDecoration(
// border: Border.all(color: kPurpleColor),
// borderRadius: BorderRadius.circular(8)),
// alignment: Alignment.center,
// child: Obx(() => Text(startDate.value.toLongDate())),
// ),
// ),
// ),
// verticalSpace(0.02),
// // add button here in edit mode
// verticalSpace(0.05),
// ],
// ),
// ).marginSymmetric(horizontal: 20),
// ],
// ),
// ),
