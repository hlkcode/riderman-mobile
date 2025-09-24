import 'package:flutter/material.dart';
import 'package:flutter_tools/tools_models.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:get/get.dart';
import 'package:riderman/shared/constants.dart';

import '../shared/common.dart';
import '../shared/config.dart';
import '../widgets/assets_list.dart';
import '../widgets/dashboard.dart';
import 'new_asset_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/MainPage';

  MainPage({super.key});

  RxInt position = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SimpleBottomTabsPage.noDrawer(
        // appBar: AppBar(),
        onPageChanged: (index) => position.value = index,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: kPurpleColor,
          onPressed: () {
            if (currentUser.isRider) {
              showInfoToast(
                  'Your current profile does not allow you to add new asset, please go to account page and switch profile to proceed.');
            } else {
              Get.toNamed(NewAssetPage.routeName);
            }
            // Get.toNamed(NewAssetPage.routeName);
          },
          child: const Icon(size: 36, Icons.add, color: Colors.white),
        ),
        // bottomTabsType: SimpleBottomTabsType.bottomSelection,
        selectedColor: kPurpleColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // backgroundColor: kPurpleLightColor,
        iconSize: 32,
        tabItems: [
          BottomTabItem(
            tabTitle: 'Home',
            icon: Icon(Icons.home_outlined),
            widget: Dashboard(),
          ),
          BottomTabItem(
            tabTitle: 'Assets',
            // icon: Icon(Icons.traffic_outlined),
            icon: Icon(Icons.token),
            // icon: Icon(Icons.support_outlined),
            // icon: Icon(Icons.diamond_outlined),
            widget: AssetsList(),
          ),
          BottomTabItem(
            tabTitle: 'Settings',
            icon: Icon(Icons.settings),
            widget: Center(child: Text('SETTINGS', style: kPurpleTextStyle)),
          ),
          BottomTabItem(
            tabTitle: 'Account',
            icon: Icon(Icons.account_circle),
            widget: Center(child: Text('ACCOUNT', style: kPurpleTextStyle)),
          ),
        ],
      ),
    );
  }
}
