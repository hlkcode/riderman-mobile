import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/models/core_models.dart';
import 'package:riderman/shared/config.dart';

import '../controllers/main_controller.dart';
import '../shared/constants.dart';
import '../widgets/labeled_widgets.dart';
import '../widgets/selectable_widgets.dart';

class IdentificationPage extends StatelessWidget {
  static const String routeName = '/IdentificationPage';
  final Property? property;
  IdentificationPage({super.key, this.property});

  final MainController mainController = Get.find();
  final RxString photoUrl = ''.obs;
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> phoneControllers = [];
  final List<RxString> urls = [];
  final RxList<Widget> cards = <Widget>[].obs;
  final List<Map<String, String>> guarantors = [];
  @override
  Widget build(BuildContext context) {
    if (property != null) {
      for (int i = 0; i < 2; i++) {
        // for (int i = 0; i < property!.guarantorsNeeded; i++) {
        nameControllers.add(TextEditingController());
        phoneControllers.add(TextEditingController());
        urls.add(''.obs);
        var card = GuarantorInputCard(
          title: 'Guarantor ${i + 1}',
          nameCtrl: nameControllers[i],
          phoneNumberCtrl: phoneControllers[i],
          photoUrl: urls[i],
          onDelete: () {
            // clear picture
          },
        );
        cards.add(card);
        cards.add(verticalSpace(0.05));
      }
    }
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () => Get.back(),
        //   icon: Icon(Icons.arrow_back_outlined),
        // ),
        title: Text('Identification Page'),
        centerTitle: true,
      ),
      body: currentUser.isRider && currentUser.isIdCardPending
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              spacing: getHeight(0.02),
              children: [
                verticalSpace(0.02),
                Text(
                  'Please your ID is under verification, we will notify you shortly when we are done.'
                  'Feel free to check the status anytime',
                  style: kBlackTextStyle,
                ),
                verticalSpace(0.05),
                Obx(
                  () => LoadingButton(
                    text: 'CHECK STATUS',
                    isLoading: mainController.getMeLoading.value,
                    buttonColor: kPurpleColor,
                    style: kWhiteTextStyle,
                    buttonRadius: 12,
                    btnMargin: EdgeInsets.zero,
                    onTapped: () async {
                      await mainController.getMe();
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16)
          : property == null
              ? Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: getHeight(0.02),
                  children: [
                    verticalSpace(0.02),
                    Text(
                      'Please an ID verification is needed to proceed.'
                      '\nSo please upload a picture of your current valid ID Card to proceed',
                      style: kBlackTextStyle,
                    ),
                    verticalSpace(0.02),
                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        // options: RectDottedBorderOptions(
                        dashPattern: [10, 5],
                        strokeWidth: 2,
                        strokeCap: StrokeCap.round,
                        color: kPurpleLightColor,
                        padding: EdgeInsets.all(16),
                        radius: Radius.circular(12),
                      ),
                      child: InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => photoUrl.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                      verticalSpace(0.01),
                                      Text(
                                        'Click here to add a photo',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                      ),
                                    ],
                                  )
                                : Image.file(
                                    File(photoUrl.value),
                                    filterQuality: FilterQuality.high,
                                    height: 200,
                                    width: getDisplayWidth(),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        onTap: () {
                          if (mainController.setIdCardLoading.value) return;
                          HlkDialog.showHorizontalDialog(
                            title: 'Select source',
                            qMessage: '\nSelect an option to add photo\n',
                            yesLabel: 'Open camera',
                            positiveAction: () async {
                              var img =
                                  await MediaManager.openCameraToTakePicture(
                                maxHeight: 250,
                                maxWidth: getDisplayWidth(),
                                imageQuality: 100,
                              );
                              if (img != null) photoUrl.value = img.path;
                              Get.back();
                            },
                            noLabel: 'Open gallery',
                            negativeAction: () async {
                              var img =
                                  await MediaManager.selectImageFromGallery(
                                maxHeight: 250,
                                maxWidth: getDisplayWidth(),
                                imageQuality: 100,
                              );
                              if (img != null) photoUrl.value = img.path;
                              Get.back();
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(0.05),
                    Obx(
                      () => LoadingButton(
                        text: 'PROCEED',
                        isLoading: mainController.setIdCardLoading.value,
                        buttonColor: kPurpleColor,
                        style: kWhiteTextStyle,
                        buttonRadius: 12,
                        btnMargin: EdgeInsets.zero,
                        onTapped: () async {
                          if (photoUrl.isEmpty) {
                            HlkDialog.showErrorSnackBar(
                              'Please take a picture of your valid ID Card to proceed',
                            );
                            return;
                          }
                          var isGood =
                              await mainController.setIdCard(photoUrl.value);
                          // if (isGood) {
                          //   Timer(Duration(seconds: 2),
                          //       () => Get.offAll(() => IdentificationPage()));
                          // }
                        },
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16)
              : SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        SelectableCard(
                          showSelection: false,
                          isSelected: false,
                          cardTitle: 'Verify Information',
                          rows: {
                            'Plate number': property?.plateNumber ?? '-',
                            'Asset type': property?.propertyType ?? '-',
                            'Type of Contract': property?.contractType ?? '-',
                            'Frequency': property?.paymentFrequency ?? '-',
                            'N. of Sales Expected':
                                property?.expectedSalesCount.toString() ?? '-',
                            'Sale Amount':
                                property?.amountAgreed.toMoney('GHS') ?? '-',
                            'Initial Deposit':
                                property?.deposit.toMoney('GHS') ?? '-',
                            'Total Expected':
                                property?.totalExpected.toMoney('GHS') ?? '-',
                            'Start Date':
                                property?.startDate.toLongDate() ?? '-',
                          },
                        ),
                        verticalSpace(0.02),
                        ...cards,
                        verticalSpace(0.02),
                        Obx(
                          () => LoadingButton(
                            text: 'SUBMIT',
                            isLoading: mainController.setIdCardLoading.value,
                            buttonColor: kPurpleColor,
                            style: kWhiteTextStyle,
                            buttonRadius: 12,
                            // btnMargin: EdgeInsets.zero,
                            onTapped: () async {
                              //prepare data
                              for (int i = 0; i < 2; i++) {
                                // for (int i = 0; i < property!.guarantorsNeeded; i++) {
                                var name = nameControllers[i].text;
                                var phone = phoneControllers[i].text;
                                var url = urls[i].value;

                                if (name.isEmpty) {
                                  HlkDialog.showErrorSnackBar(
                                      'Invalid name for Guarantor ${i + 1}');
                                  break;
                                }
                                var er = phoneNumberValidator(phone);
                                if (er != null) {
                                  HlkDialog.showErrorSnackBar(
                                      'Invalid phone number for Guarantor ${i + 1}');
                                  break;
                                }
                                if (url.isEmpty) {
                                  HlkDialog.showErrorSnackBar(
                                      'Invalid photo for Guarantor ${i + 1}');
                                  break;
                                }

                                var guarantor = {
                                  'fullName': name,
                                  'phoneNumber': phone,
                                  'photo': url,
                                };
                                guarantors.add(guarantor);
                              }
                              if (guarantors.length != 2) return;
                              // if(guarantors.length != property!.guarantorsNeeded) return;
                              //
                              logInfo(guarantors);
                              var propId = getNumber(property?.id) as int;

                              await mainController.connect(propId, guarantors);
                            },
                          ),
                        ),
                        verticalSpace(0.02)
                      ],
                    ).paddingSymmetric(horizontal: 16),
                  ),
                ),
    );
  }
}

class GuarantorInputCard extends StatelessWidget {
  final String title;
  final bool isReadOnly;
  final TextEditingController nameCtrl;
  final TextEditingController phoneNumberCtrl;
  final RxString photoUrl;
  final Function()? onDelete;

  GuarantorInputCard({
    super.key,
    required this.title,
    required this.nameCtrl,
    required this.phoneNumberCtrl,
    required this.photoUrl,
    this.onDelete,
    this.isReadOnly = false,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // spacing: getHeight(0.02),
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: kPurpleTextStyle),
            IconButton(
              color: kPurpleColor,
              onPressed: onDelete,
              icon: Icon(Icons.cancel_outlined),
            )
          ]),

          Obx(
            () => photoUrl.isEmpty
                ? DottedBorder(
                    options: RectDottedBorderOptions(
                      dashPattern: [10, 5],
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      color: Colors.green,
                      padding: EdgeInsets.all(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        HlkDialog.showHorizontalDialog(
                          title: 'Select source',
                          qMessage: '\nSelect an option to add photo\n',
                          yesLabel: 'Open camera',
                          positiveAction: () async {
                            var img =
                                await MediaManager.openCameraToTakePicture(
                              maxHeight: 250,
                              maxWidth: getDisplayWidth(),
                              imageQuality: 100,
                            );
                            if (img != null) photoUrl.value = img.path;
                            Get.back();
                          },
                          noLabel: 'Open gallery',
                          negativeAction: () async {
                            var img = await MediaManager.selectImageFromGallery(
                              maxHeight: 250,
                              maxWidth: getDisplayWidth(),
                              imageQuality: 100,
                            );
                            if (img != null) photoUrl.value = img.path;
                            Get.back();
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.grey,
                              size: 40,
                            ),
                            verticalSpace(0.01),
                            Text(
                              'Click here to add a photo',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    File(photoUrl.value),
                    width: getDisplayWidth(),
                    height: 150,
                    fit: BoxFit.contain,
                  ),
          ),
          verticalSpace(0.02),
          LabeledTextField(
            title: 'Name',
            inputType: TextInputType.text,
            readOnly: isReadOnly,
            controller: nameCtrl,
            validator: requiredValidator,
          ),
          verticalSpace(0.02),
          LabeledTextField(
            readOnly: isReadOnly,
            title: 'Phone number',
            inputType: TextInputType.phone,
            controller: phoneNumberCtrl,
            validator: phoneNumberValidator,
          ),
          // verticalSpace(0.02),
        ],
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
