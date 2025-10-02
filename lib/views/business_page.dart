import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';

import '../controllers/main_controller.dart';
import '../shared/common.dart';
import '../shared/config.dart';
import '../widgets/business_overview.dart';
import '../widgets/expenses_list.dart';
import '../widgets/rider_info.dart';
import '../widgets/sales_list.dart';

class BusinessPage extends StatelessWidget {
  static const routeName = '/BusinessPage';
  final int assetIndex;
  BusinessPage({super.key, required this.assetIndex});
  final MainController mainController = Get.find();

  final tabsTitles = ['Overview', 'Sales', 'Expenses', 'Profiles'];

  RxBool showRefresh = false.obs;

  @override
  Widget build(BuildContext context) {
    var property = mainController.properties[assetIndex];

    return DefaultTabController(
      length: tabsTitles.length,
      child: Obx(
        () => Scaffold(
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
                    onTap: (index) {
                      showRefresh.value = index == 1;
                    },
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
            actions: [
              if (showRefresh.value)
                Obx(
                  () => IconButton(
                    onPressed: () async {
                      mainController.sales.clear();
                      await mainController.getPropertySales(property,
                          refresh: true);
                      // await mainController.getSales(refresh: true);
                    },
                    icon: mainController.loading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Icon(Icons.refresh),
                  ),
                )
            ],
          ),
          body: TabBarView(
            children: [
              Obx(() => BusinessOverview(
                    data: mainController.assetOverview.value,
                    property: property,
                  )),
              Obx(() => SalesList(
                    rider: property.rider,
                    sales: mainController.sales.value,
                    onSubmit: (RxList<int> selectedIndexes) async {
                      if (currentUser.isOwner) {
                        showInfoToast(
                            'Your current profile does not allow for this action');
                        return;
                      }
                      var selectedIds = mainController.sales
                          .whereIndexed((i, s) => selectedIndexes.contains(i))
                          .map((s) => s.id)
                          .toList();

                      logInfo('selectedIndexes SALES => $selectedIds');
                      var toCharge = getString(property.rider?.phoneNumber);
                      // todo: add option to enter number to charge
                      await mainController.initiatePayment(
                        toCharge,
                        selectedIds,
                      );
                      selectedIndexes
                          .clear(); // to deselect the list when request is done
                    },
                  )),
              ExpensesList(),
              RiderInfo(rider: property.rider),
              // RiderInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
