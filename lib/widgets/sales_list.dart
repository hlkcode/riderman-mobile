import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../shared/constants.dart';
import 'labeled_widgets.dart';

class SalesList extends StatelessWidget {
  SalesList({super.key});

  final TextEditingController riderCtrl = TextEditingController();
  final MainController mainController = Get.find();

  RxList<int> selectedIndexes = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    var list = ListView.separated(
      itemCount: mainController.sales.length,
      itemBuilder: (ctx, index) {
        var item = mainController.sales[index];
        var mainContent = Card(
          elevation: 0.0,
          color: Colors.white54,
          child: Column(
            // spacing: getHeight(0.01),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment #${index + 1}',
                style: kBlackTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              SaleRow(title: 'Amount', value: item.amount.toMoney('GHS')),
              SaleRow(title: 'Expected Date', value: item.dueDate.toLongDate()),
              SaleRow(title: 'Status', value: item.saleStatus),
              SaleRow(title: 'Reference', value: item.paymentRef),
              SaleRow(
                  title: 'Last Updated',
                  value: item.updatedAt?.toLongDateTime() ?? '-'),
              verticalSpace(0.01),
              LoadingButton(
                btnMargin: EdgeInsets.zero,
                // buttonHeight: getHeight(0.04),
                buttonHeight: 36,
                text: 'Select to Pay',
                isOutlined: true,
                isLoading: false,
                buttonColor: kPurpleColor,
                style: kPurpleTextStyle,
                buttonRadius: 12,
                onTapped: () {
                  if (!selectedIndexes.contains(index)) {
                    selectedIndexes.add(index);
                  }
                },
              ),
            ],
          ).paddingAll(12),
        );
        return Obx(
          () => selectedIndexes.isNotEmpty
              ? Row(
                  children: [
                    Checkbox(
                      value: selectedIndexes.contains(index),
                      onChanged: (selected) {
                        selectedIndexes.addOrRemove(index);
                      },
                    ),
                    Expanded(child: mainContent),
                  ],
                )
              : mainContent,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          verticalSpace(0.008),
    );
    return Container(
      color: kPurpleLightColor.withOpacity(.2),
      child: Obx(
        () => selectedIndexes.isEmpty
            ? list
            : Column(
                // spacing: getHeight(0.008),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // verticalSpace(0.002),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => selectedIndexes.clear(),
                        icon: Icon(Icons.cancel_outlined, size: 32),
                      ),
                      Text(
                        '${selectedIndexes.length} Selected',
                        style: kPurpleTextStyle,
                        // style: kBlackTextStyle,
                      ),
                      SizedBox(
                        width: 110,
                        child: LoadingButton(
                          // btnMargin: EdgeInsets.zero,
                          // buttonHeight: getHeight(0.04),
                          buttonHeight: 36,
                          text: 'Pay Now',
                          // isOutlined: true,
                          style: kWhiteTextStyle,
                          isLoading: false,
                          buttonColor: kPurpleColor,
                          buttonRadius: 12,
                          onTapped: () {},
                        ),
                      ),
                    ],
                  ),
                  LabeledWidget(
                    title: 'Select All',
                    isVertical: false,
                    widget: Checkbox(
                      value:
                          selectedIndexes.length == mainController.sales.length,
                      onChanged: (sel) {
                        var limit = mainController.sales.length;
                        selectedIndexes.value =
                            List<int>.generate(limit, (i) => i);
                      },
                    ),
                  ),
                  Expanded(child: list)
                ],
              ),
      ).marginAll(10),
    );
  }
}

class SaleRow extends StatelessWidget {
  final String title;
  final String value;
  const SaleRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
