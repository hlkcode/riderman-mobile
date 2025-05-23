import 'package:flutter/material.dart';
import 'package:riderman/shared/constants.dart';

import '../models/core_models.dart';
import '../widgets/business_overview.dart';

class BusinessPage extends StatelessWidget {
  static const routeName = '/BusinessPage';
  final Property property;
  const BusinessPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
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
                  Tab(text: 'Business'),
                  Tab(text: 'Profile'),
                  Tab(text: 'Transactions'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            BusinessOverview(),
            Center(child: Text('Archived Page')),
            Center(child: Text('Deleted Page')),
          ],
        ),
      ),
    );
  }
}
