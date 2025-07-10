import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/common.dart';
import 'package:riderman/widgets/selectable_widgets.dart';

import '../controllers/main_controller.dart';
import '../shared/config.dart';
import '../shared/constants.dart';
import '../views/business_page.dart';

class AssetsList extends StatelessWidget {
  AssetsList({super.key});

  final TextEditingController riderCtrl = TextEditingController();
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (mainController.loading.isFalse) {
      mainController.getProperties();
    }
    return Container(
      color: kPurpleLightColor.withOpacity(.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(0.02),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 12),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: 'Search asset or rider',
              hintStyle: const TextStyle(color: kPurpleColor),
              fillColor: kPurpleLightColor,
              filled: true,
              suffixIcon:
                  Icon(FontAwesomeIcons.magnifyingGlass, color: kPurpleColor)
                      .marginOnly(right: 6),
            ),
            // validator: requiredValidator,
            controller: riderCtrl,
            keyboardType: TextInputType.name,
          ).marginAll(6),
          verticalSpace(0.03),
          Expanded(
            child: ListView.separated(
              itemCount: mainController.properties.length,
              itemBuilder: (ctx, index) {
                var item = mainController.properties[index];
                return InkWell(
                  onTap: () {
                    if (currentUser.isRider == false && isPending(item)) {
                      if (item.guarantorsNeeded > 0) {
                      } else {
                        HlkDialog.showDialogBox(
                          title: 'Confirmation',
                          content: SelectableCard(
                            showSelection: false,
                            isSelected: false,
                            cardTitle: '',
                            rows: {
                              'Plate number': item.plateNumber,
                              'Asset type': item.propertyType,
                              'Type of Contract': item.contractType,
                              'Frequency': item.paymentFrequency,
                              'N. of Sales Expected':
                                  item.expectedSalesCount.toString(),
                              'Sale Amount': item.amountAgreed.toMoney('GHS'),
                              'Deposit': item.deposit.toMoney('GHS'),
                              'Total Expected':
                                  item.totalExpected.toMoney('GHS'),
                              'Start Date': item.startDate.toLongDate(),
                            },
                          ),
                          yesLabel: 'Accept',
                          noLabel: 'Back',
                          yesVoidCallBack: () {},
                        );
                      }
                      return;
                    }
                    Get.to(() => BusinessPage(index: index));
                  },
                  child: Card(
                    elevation: 0.0,
                    color: Colors.white54,
                    child: Row(
                      children: [
                        Card(
                          color: kPurpleLightColor,
                          child: SizedBox(
                            height: getHeight(0.05),
                            width: getHeight(0.07),
                            child: Icon(
                              getPropertyIcon(item.propertyType),
                              size: 32,
                              color: kPurpleColor,
                            ),
                          ).marginSymmetric(vertical: 6),
                        ),
                        // horizontalSpace(0.02),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.plateNumber.toUpperCase(),
                                    maxLines: 1,
                                    style: kBlackTextStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('+ 17',
                                      maxLines: 1,
                                      style: kPurpleTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              verticalSpace(0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getBoolean(GetUtils.isNullOrBlank(
                                            item.rider?.fullName))
                                        ? 'No rider linked yet'
                                        : '${item.rider?.fullName} | ${item.rider?.phoneNumber}',
                                    maxLines: 1,
                                  ),
                                  Text(
                                    item.propertyStatus.capitalizeFirst!,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ).marginSymmetric(horizontal: 12),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 6, vertical: 6),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  verticalSpace(0.008),
            ).marginAll(4),
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 24),
    );
  }
}
