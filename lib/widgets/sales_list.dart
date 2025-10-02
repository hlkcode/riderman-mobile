import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:get/get.dart';
import 'package:riderman/widgets/selectable_widgets.dart';

import '../controllers/main_controller.dart';
import '../models/core_models.dart';

class SalesList extends StatelessWidget {
  final Rider? rider;
  final List<Sale> sales;
  final Function(RxList<int> selectedIndexes)? onSubmit;
  SalesList({
    super.key,
    this.rider,
    required this.sales,
    required this.onSubmit,
  });

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    var rowsMap = sales
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
      reversed: true,
      dataList: sales.reversed.toList(),
      loading: mainController.paymentLoading,
      cardFor: 'Payment',
      cardActionText: 'Select to Pay',
      rowsList: rowsMap.reversed.toList(),
      submitText: 'Pay',
      onSelectedSubmit: onSubmit,
      // onSelectedSubmit: (selectedIndexes) async {
      //   var selectedIds = mainController.sales
      //       .whereIndexed((i, s) => selectedIndexes.contains(i))
      //       .map((s) => s.id)
      //       .toList();
      //
      //   logInfo('selectedIndexes SALES => $selectedIds');
      //   var toCharge = getString(rider?.phoneNumber);
      //   await mainController.initiatePayment(toCharge, selectedIds);
      //   selectedIndexes.clear(); // to deselect the list when request is done
      // },
    );
  }
}
