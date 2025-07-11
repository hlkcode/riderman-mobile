import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:get/get.dart';
import 'package:riderman/widgets/selectable_widgets.dart';

import '../controllers/main_controller.dart';

class SalesList extends StatelessWidget {
  SalesList({super.key});

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    var rowsMap = mainController.sales
        .map((item) => {
              'Amount': item.amount.toMoney('GHS'),
              'Expected Date': item.dueDate.toLongDate(),
              'Status': item.saleStatus,
              'Reference': item.paymentRef,
              'Last Updated': item.updatedAt?.toLongDateTime() ?? '-',
            })
        .toList();
    //
    return SelectableListPage(
      cardFor: 'Payment',
      cardActionText: 'Select to Pay',
      dataList: mainController.sales,
      rowsList: rowsMap,
      submitText: 'Pay Now',
      onSubmit: () {},
    );
  }
}
