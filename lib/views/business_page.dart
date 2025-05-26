import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';

import '../controllers/main_controller.dart';
import '../widgets/business_overview.dart';
import '../widgets/rider_info.dart';

class BusinessPage extends StatelessWidget {
  static const routeName = '/BusinessPage';
  final int index;
  BusinessPage({super.key, required this.index});
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    var property = mainController.properties[index];
    return DefaultTabController(
      length: 3,
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
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: kPurpleLightColor,
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: kPurpleColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                labelColor: kPurpleLightColor,
                unselectedLabelColor: kPurpleColor,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Rider\'s Info'),
                  Tab(text: 'Transactions'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() =>
                BusinessOverview(data: mainController.overviewData.value)),
            RiderInfo(property: property),
            const Center(child: Text('Deleted Page')),
          ],
        ),
      ),
    );
  }
}
