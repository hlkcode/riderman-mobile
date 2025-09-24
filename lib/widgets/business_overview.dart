import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/core_models.dart';
import '../shared/constants.dart';
import '../views/asset_details_page.dart';

class BusinessOverview extends StatelessWidget {
  final AssetOverview data;
  final Property property;
  const BusinessOverview(
      {super.key, required this.data, required this.property});

  @override
  Widget build(BuildContext context) {
    var purple20 = kPurpleTextStyle.copyWith(fontSize: 20);
    var boldPurple =
        purple20.copyWith(fontSize: 20, fontWeight: FontWeight.bold);
    var amount = 'GHS ${data.paid}';
    var textAmount = Text(amount, style: boldPurple);
    return Column(
      children: [
        verticalSpace(0.02),
        BusinessCard(
          singleContent: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    amount.length >= 10
                        ? FittedBox(child: textAmount)
                        : textAmount,
                    Text('Amount paid so far', style: kPurpleTextStyle),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircularPercentIndicator(
                    radius: 48,
                    lineWidth: 8.0,
                    percent: data.paidPercentage / 100,
                    center: Text('${data.paidPercentage}%', style: boldPurple),
                    progressColor: kPurpleColor,
                    backgroundColor: Colors.white,
                    animation: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(0.02),
        BusinessCard(
          content: [
            Expanded(
              child: VerticalText(
                  amount: data.expectedSalesCount.toString().padLeft(2, '0'),
                  title: 'Total Txn',
                  dotColor: kPurpleColor),
            ),
            Expanded(
              child: VerticalText(
                  amount: data.paidSalesCount.toString().padLeft(2, '0'),
                  title: 'Paid Txn',
                  dotColor: Colors.green),
            ),
            Expanded(
              child: VerticalText(
                  amount: data.leftSalesCount.toString().padLeft(2, '0'),
                  title: 'Balance Txn',
                  dotColor: Colors.deepOrange),
            ),
          ],
        ),
        verticalSpace(0.02),
        BusinessCard(
          singleContent: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DottedText(dotColor: Colors.green, title: 'Paid'),
                  FittedBox(
                    child: Text('GHS ${data.paid}', style: purple20),
                  ),
                ],
              ),
              verticalSpace(0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DottedText(dotColor: Colors.deepOrange, title: 'Balance'),
                  FittedBox(
                    child: Text('GHS ${data.remaining}', style: purple20),
                  ),
                ],
              ),
              verticalSpace(0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DottedText(dotColor: kPurpleColor, title: 'Total'),
                  FittedBox(
                    child: Text('GHS ${data.totalExpected}', style: purple20),
                  ),
                ],
              ),
            ],
          ),
        ),
        verticalSpace(0.02),
        GestureDetector(
          onTap: () {
            // go to asset/property details page
            Get.to(() => AssetDetailsPage(property: property));
          },
          child: BusinessCard(
            cardColor: kPurpleColor,
            singleContent: Text(
              'View Detailed Information',
              style: kWhiteTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 20),
            ).paddingSymmetric(vertical: 36),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 24);
  }
}

class BusinessCard extends StatelessWidget {
  final List<Widget> content;
  final Widget? singleContent;
  final Color cardColor;

  const BusinessCard(
      {super.key,
      this.content = const [],
      this.cardColor = kPurpleLightColor,
      this.singleContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: content.isNotEmpty ? getHeight(0.15) : null,
      width: getDisplayWidth(),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: singleContent ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          ),
    );
  }
}

class VerticalText extends StatelessWidget {
  final String amount;
  final String title;
  final Color dotColor;

  const VerticalText(
      {super.key,
      required this.amount,
      required this.title,
      required this.dotColor});

  @override
  Widget build(BuildContext context) {
    var textAmount = Text(amount,
        style: kPurpleTextStyle.copyWith(
            fontSize: 20, fontWeight: FontWeight.bold));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        amount.length >= 8 ? FittedBox(child: textAmount) : textAmount,
        verticalSpace(0.01),
        DottedText(title: title, dotColor: dotColor),
      ],
    );
  }
}

class DottedText extends StatelessWidget {
  final Color dotColor;
  final String title;
  const DottedText({super.key, required this.dotColor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(24),
            // shape: BoxShape.circle,
          ),
          child: SizedBox(height: 10, width: 10),
        ),
        horizontalSpace(0.02),
        Text(title, style: kPurpleTextStyle)
      ],
    );
  }
}
