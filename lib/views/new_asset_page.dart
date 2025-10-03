import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../models/core_models.dart';
import '../models/dto_models.dart';
import '../shared/common.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import '../widgets/labeled_widgets.dart';

class NewAssetPage extends StatelessWidget {
  static const String routeName = '/NewAssetPage';

  NewAssetPage({super.key});
  //
  final MainController mainController = Get.find();
  //
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<String> nExpectedPayments = '0'.obs;
  RxBool isManaged = false.obs;
  //
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  //
  final txtRiderPhone = TextEditingController();
  final txtPlateNumber = TextEditingController();
  final txtNGuarantors = TextEditingController();
  final txtTotalExpected = TextEditingController();
  final txtAmountAgreed = TextEditingController();
  final txtDeposit = TextEditingController();
  final txtPartnerClientRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var contracts =
        ContractType.values.map((e) => e.name.toUpperCase()).toList();
    var assetTypes =
        PropertyType.values.map((e) => e.name.toUpperCase()).toList();
    var frequencies =
        PaymentFrequency.values.map((e) => e.name.toUpperCase()).toList();
    //
    var contractType = '';
    var propertyType = '';
    var paymentFrequency = '';
    //
    return Scaffold(
      // backgroundColor: kPurpleLightColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text('New Asset'),
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
                      controller: txtRiderPhone,
                    ),
                    LabeledTextField(
                      title: 'Number plate',
                      validator: requiredValidator,
                      inputType: TextInputType.text,
                      controller: txtPlateNumber,
                    ),
                    LabeledSelector(
                      title: 'Contract type',
                      options: contracts,
                      instruction: 'Select contract type',
                      onSelectionChange: (newValue) =>
                          contractType = getString(newValue),
                    ),
                    LabeledSelector(
                      title: 'Type of Asset',
                      options: assetTypes,
                      instruction: 'Select Asset type',
                      onSelectionChange: (newValue) =>
                          propertyType = getString(newValue),
                    ),
                    LabeledTextField(
                      controller: txtNGuarantors,
                      title: 'Number of Guarantor(s) Required',
                      inputType: TextInputType.number,
                    ),
                    // verticalSpace(0.1),
                    if (currentCompany.isPartner)
                      LabeledSwitch(
                        currentValue: isManaged,
                        title: 'Managed Property',
                        switchSubTitle:
                            'Enable this if you are you managing this property for a third party',
                        // switchTitle:
                        //     'Enable this if you are you managing this property for a third party',
                      ),
                    Obx(
                      () => isManaged.value
                          ? LabeledTextField(
                              validator: requiredValidator,
                              controller: txtPartnerClientRate,
                              title: 'Management Interest rate',
                              inputType: TextInputType.numberWithOptions(
                                  decimal: true),
                            )
                          : SizedBox.shrink(),
                    ),
                    Obx(
                      () => isManaged.value
                          ? verticalSpace(0.05)
                          : SizedBox.shrink(),
                    ),
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
                      controller: txtTotalExpected,
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
                      controller: txtAmountAgreed,
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
                      controller: txtDeposit,
                      title: 'Initial Deposit / Amount Paid Previously',
                      inputType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    LabeledSelector(
                      title: 'Payment Frequency',
                      options: frequencies,
                      instruction: 'Select Payment Frequency',
                      onSelectionChange: (newValue) =>
                          paymentFrequency = getString(newValue),
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
                          startDate.value = pickedDate ?? now;
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
            child: Obx(() => LoadingButton(
                  // buttonHeight: getHeight(0.06),
                  text: 'CREATE',
                  isLoading: mainController.loading.value,
                  buttonColor: kPurpleColor,
                  style: kWhiteTextStyle,
                  buttonRadius: 12,
                  onTapped: currentUser.isRider
                      ? null
                      : () async {
                          //
                          // check if anything change before allowing the call to go through
                          var nPhoneNumber = txtRiderPhone.text.trim();
                          var nPlateNumber = txtPlateNumber.text.trim();
                          var nGuarantors =
                              int.parse(txtNGuarantors.text.trim());
                          //
                          var nTotalExpected =
                              double.parse(txtTotalExpected.text.trim());
                          var nDeposit = double.parse(txtDeposit.text.trim());
                          var nAgreed =
                              double.parse(txtAmountAgreed.text.trim());
                          var nPartnerRate =
                              double.parse(txtPartnerClientRate.text.trim());
                          //
                          if (nPhoneNumber.isEmpty ||
                              nPlateNumber.isEmpty ||
                              contractType.isEmpty ||
                              propertyType.isEmpty ||
                              (isManaged.isTrue && nPartnerRate == 0) ||
                              nTotalExpected == 0 ||
                              nAgreed == 0 ||
                              nDeposit == 0 ||
                              paymentFrequency.isEmpty) {
                            showInfoToast(
                                'Please fill all the required fields');
                            logInfo(
                                '============= Missing data ==============');
                            return;
                          }

                          var manType =
                              currentCompany.email == 'halikapps@gmail.com' &&
                                      isManaged.value
                                  ? ManagementType.Managed
                                  : isManaged.value && nPartnerRate > 0
                                      ? ManagementType.Partner
                                      : ManagementType.None;
                          //
                          var dto = PropertyDto(
                            companyId: currentCompany.id,
                            amountAgreed: nAgreed,
                            contractType: contracts.indexOf(contractType),
                            deposit: nDeposit,
                            guarantorsNeeded: nGuarantors,
                            paymentFrequency:
                                frequencies.indexOf(paymentFrequency),
                            managementType: manType.index,
                            plateNumber: nPlateNumber,
                            propertyType: assetTypes.indexOf(propertyType),
                            riderPhoneNumber: nPhoneNumber,
                            startDate: startDate.value,
                            totalExpected: nTotalExpected,
                            partnerClientRate: nPartnerRate,
                          );
                          //
                          await mainController.createProperty(dto);
                          // refresh the properties
                          await mainController.getProperties(
                            refresh: true,
                            loadData: true,
                          );
                          Get.back();
                        },
                )),
          ),
        ),
      ),
    );
  }
}

// SingleChildScrollView(
// child: Column(
// spacing: getHeight(0.02),
// // mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// verticalSpace(0.02),
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
// LabeledSelector(
// title: 'Payment Frequency',
// options: PaymentFrequency.values.map((e) => e.name).toList(),
// instruction: 'Select Payment Frequency',
// onSelectionChange: (newValue) {},
// ),
// LabeledTextField(
// title: 'Instalment Amount',
// validator: (newValue) {
// var res = requiredValidator(newValue);
// if (!getBoolean(GetUtils.isNullOrBlank(res))) return res;
//
// return GetUtils.isNum(getString(newValue))
// ? null
//     : 'Invalid number detected';
// },
// inputType: TextInputType.numberWithOptions(decimal: true),
// ),
// LabeledTextField(
// title: 'Total Expected',
// validator: (newValue) {
// var res = requiredValidator(newValue);
// if (!getBoolean(GetUtils.isNullOrBlank(res))) return res;
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
// LabeledTextField(
// title: 'Initial Deposit / Amount Paid Previously',
// inputType: TextInputType.numberWithOptions(decimal: true),
// ),
// LabeledTextField(
// title: 'Number of Guarantor(s) Required',
// inputType: TextInputType.number,
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
// LoadingButton(
// // buttonHeight: getHeight(0.06),
// btnMargin: EdgeInsets.zero,
// text: 'Save',
// isLoading: false,
// buttonColor: kPurpleColor,
// style: kWhiteTextStyle,
// // buttonRadius: 12,
// onTapped: () {},
// ),
// verticalSpace(0.1),
// ],
// ).marginSymmetric(horizontal: 12),
// )
