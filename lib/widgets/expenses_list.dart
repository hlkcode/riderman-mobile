import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:get/get.dart';
import 'package:riderman/widgets/selectable_widgets.dart';

import '../controllers/main_controller.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key});

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    var rowsMap = mainController.expenses
        .map((item) => {
              'Amount': item.amount.toMoney('GHS'),
              'Description': item.description,
              'Occurrence Date': item.date.toLongDate(),
              'Recorded': item.createdAt.toLongDateTime(),
              'Last Updated': item.updatedAt?.toLongDateTime() ?? '-',
            })
        .toList();
    //
    return SelectableListPage(
      cardFor: 'Expense',
      cardActionText: 'Select to Delete',
      dataList: mainController.expenses,
      rowsList: rowsMap,
      submitText: 'Delete',
      onSubmit: () {},
    );
  }
}
