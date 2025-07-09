import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';

import '../controllers/main_controller.dart';
import '../widgets/business_overview.dart';
import '../widgets/expenses_list.dart';
import '../widgets/rider_info.dart';
import '../widgets/sales_list.dart';

class BusinessPage extends StatelessWidget {
  static const routeName = '/BusinessPage';
  final int index;
  BusinessPage({super.key, required this.index});
  final MainController mainController = Get.find();

  final tabsTitles = ['Overview', 'Sales', 'Expenses', 'Profiles'];

  @override
  Widget build(BuildContext context) {
    var property = mainController.properties[index];
    return DefaultTabController(
      length: tabsTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            property.plateNumber,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: kPurpleLightColor,
              ),
              child: TabBar(
                  // isScrollable: tabsTitles.length > 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: kPurpleColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  labelColor: kPurpleLightColor,
                  unselectedLabelColor: kPurpleColor,
                  tabs: tabsTitles.map((it) => Tab(text: it)).toList()
                  // const [
                  //   Tab(text: 'Overview'),
                  //   Tab(text: 'Rider\'s Info'),
                  //   Tab(text: 'Transactions'),
                  //   Tab(text: 'Expenses'),
                  // ],
                  ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() =>
                BusinessOverview(data: mainController.assetOverview.value)),
            SalesList(),
            ExpensesList(),
            RiderInfo(rider: property.rider),
            // RiderInfo(),
          ],
        ),
      ),
    );
  }
}
