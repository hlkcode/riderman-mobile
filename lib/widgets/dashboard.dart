import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/extension_methods.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../shared/constants.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (mainController.loading.isFalse) {
      mainController.getAccountOverviewData();
    }
    final blackStyle =
        kBlackTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 18);
    final smallWhiteStyle =
        kWhiteTextStyle.copyWith(fontWeight: FontWeight.w500);
    final bigWhiteStyle =
        kWhiteTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 20);
    return Container(
      color: kPurpleLightColor.withOpacity(.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            // style: blackStyle,
            TextSpan(
              children: [
                TextSpan(text: 'Hello, ', style: blackStyle),
                TextSpan(
                  text: 'Halik',
                  style: kPurpleTextStyle.copyWith(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Obx(
              () => DashboardCard(
                title: 'Total Earnings',
                titleStyle: bigWhiteStyle,
                smallStyle: bigWhiteStyle,
                amountStyle: bigWhiteStyle, //.copyWith(fontSize: 24),
                amount: mainController.accountOverview.value.totalEarnings
                    .toMoney('GHS'),
                assetCount: mainController
                    .accountOverview.value.totalPropertyCount
                    .toString(),
                transactionCount: mainController
                    .accountOverview.value.totalPaidSalesCount
                    .toString(),
              ).marginSymmetric(vertical: 16),
            ),
          ),
          verticalSpace(0.015),
          Text(
            'Transportation Types',
            style: blackStyle,
          ),
          verticalSpace(0.015),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => DashboardCard(
                      smallStyle: smallWhiteStyle,
                      amountStyle: bigWhiteStyle,
                      amount: mainController.accountOverview.value.carEarnings
                          .toMoney('GHS'),
                      assetCount: mainController.accountOverview.value.carCount
                          .toString(),
                      transactionCount: mainController
                          .accountOverview.value.carSalesCount
                          .toString(),
                      titleIconSize: 36,
                      titleIcon: FontAwesomeIcons.car,
                    ),
                  ),
                ),
                horizontalSpace(0.025),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => DashboardCard(
                          smallStyle: smallWhiteStyle,
                          amountStyle: bigWhiteStyle,
                          amount: mainController
                              .accountOverview.value.bikeEarnings
                              .toMoney('GHS'),
                          assetCount: mainController
                              .accountOverview.value.bikeCount
                              .toString(),
                          transactionCount: mainController
                              .accountOverview.value.bikeSalesCount
                              .toString(),
                          // titleIconSize: 42,
                          titleIcon: FontAwesomeIcons.motorcycle,
                          cardColor: kPurpleColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                    verticalSpace(0.015),
                    Expanded(
                      child: Obx(
                        () => DashboardCard(
                            smallStyle: smallWhiteStyle,
                            amountStyle: bigWhiteStyle,
                            amount: mainController
                                .accountOverview.value.trucEarnings
                                .toMoney('GHS'),
                            assetCount: mainController
                                .accountOverview.value.trucCount
                                .toString(),
                            transactionCount: mainController
                                .accountOverview.value.trucSalesCount
                                .toString(),
                            // titleIconSize: 42,
                            titleIcon: FontAwesomeIcons.truck,
                            cardColor: kPurpleLightColor,
                            smallIconColor: kPurpleColor,
                            mainIconBackgroundColor: Colors.white
                            // mainIconColor: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          verticalSpace(0.04),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 24),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final TextStyle? smallStyle;
  final TextStyle? titleStyle;
  final TextStyle? amountStyle;
  final Color cardColor;
  final Color? mainIconBackgroundColor;
  final Color smallIconColor;
  final IconData titleIcon;
  final double? titleIconSize;
  final String amount;
  final String assetCount;
  final String transactionCount;

  const DashboardCard(
      {super.key,
      this.title = '',
      this.smallStyle,
      this.titleStyle,
      this.amountStyle,
      this.cardColor = kPurpleColor,
      this.mainIconBackgroundColor,
      this.smallIconColor = Colors.white,
      this.titleIconSize,
      this.titleIcon = Icons.diamond_outlined,
      required this.amount,
      required this.assetCount,
      required this.transactionCount});

  @override
  Widget build(BuildContext context) {
    // final miniWhiteStyle = kWhiteTextStyle.copyWith(
    //     fontWeight: FontWeight.w700, fontSize: 24, color: textColor);

    var leftMargin = title.isNotEmpty ? 16.0 : 6.0;
    var spacing = title.isNotEmpty ? 8.0 : 4.0;
    var miniIconSize = title.isNotEmpty ? 32.0 : null;
    var maxChar = title.isNotEmpty ? 12 : 7;
    var isMax = amount.length >= maxChar;
    var textAmount = Text(
      amount,
      style: isMax
          ? amountStyle?.copyWith(
              fontSize: getNumber(amountStyle?.fontSize) - 16)
          : amountStyle?.copyWith(
              fontSize: getNumber(amountStyle?.fontSize) + 10),
      maxLines: 1,
      // overflow: TextOverflow.ellipsis,
    );

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(title, style: titleStyle).marginOnly(left: leftMargin),
          if (title.isEmpty)
            CircleAvatar(
              backgroundColor: mainIconBackgroundColor ?? kPurpleLightColor,
              radius: titleIconSize != null ? (titleIconSize! - 8) : null,
              child:
                  FaIcon(titleIcon, size: titleIconSize, color: kPurpleColor),
              // child: Icon(titleIcon, size: titleIconSize, color: kPurpleColor),
              // child: ImageIcon(
              //   AssetImage(titleIcon),
              //   color: kPurpleColor,
              // ),
            ),
          // Wrap the Text with Expanded and Row. When you don't wrap it with
          // Expanded, the Text tries to take up as much space as it needs,
          // and if that exceeds the available space, it can lead to overflow issues.
          // By wrapping it with Expanded inside a Row, you're telling Flutter to
          // allocate the remaining space to Text widget
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: (isMax
                        ? FittedBox(child: textAmount)
                        : Center(child: textAmount))
                    .marginOnly(left: leftMargin),
              ),
            ],
          ),
          verticalSpace(.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: spacing,
                children: [
                  // Icon(Icons.diamond_outlined,color: smallIconColor, ),
                  ImageIcon(AssetImage(AppConstants.ICON_RIDE_COUNT),
                      color: smallIconColor, size: miniIconSize),
                  Text(assetCount, style: smallStyle),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: spacing,
                children: [
                  // Icon(Icons.payments_outlined, color: smallIconColor, size: miniIconSize),
                  ImageIcon(AssetImage(AppConstants.ICON_TR_COUNT),
                      color: smallIconColor, size: miniIconSize),
                  Text(transactionCount, style: smallStyle),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: title.isNotEmpty ? 16 : 2.0),
        ],
      ),
    );
  }
}
