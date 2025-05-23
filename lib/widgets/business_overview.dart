import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../shared/constants.dart';

class BusinessOverview extends StatelessWidget {
  const BusinessOverview({super.key});

  @override
  Widget build(BuildContext context) {
    var boldPurple =
        kPurpleTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold);
    var amount = 'GHS 10000';
    var textAmount = Text(amount, style: boldPurple);
    return Column(
      children: [
        verticalSpace(0.02),
        BusinessCard(
          content: [
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
              child: SizedBox(
                child: CircularPercentIndicator(
                  radius: 42,
                  lineWidth: 8.0,
                  percent: 0.76,
                  center: Text('76%', style: boldPurple),
                  progressColor: kPurpleColor,
                  backgroundColor: Colors.white,
                  animation: true,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(0.02),
        BusinessCard(
          content: [
            Expanded(
              child: VerticalText(
                  amount: 'GHS1000', title: 'Total', dotColor: kPurpleColor),
            ),
            Expanded(
              child: VerticalText(
                  amount: 'GHS1000', title: 'Paid', dotColor: Colors.green),
            ),
            Expanded(
              child: VerticalText(
                  amount: 'GHS1000',
                  title: 'Remaining',
                  dotColor: Colors.deepOrange),
            ),
          ],
        ),
        verticalSpace(0.02),
        GestureDetector(
          onTap: () {},
          child: BusinessCard(
            cardColor: kPurpleColor,
            singleContent: Text(
              'View Detailed Information',
              style: kWhiteTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 20),
            ),
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
      height: getHeight(0.15),
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
    var textAmount =
        Text(amount, style: kPurpleTextStyle.copyWith(fontSize: 20));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        amount.length >= 8 ? FittedBox(child: textAmount) : textAmount,
        verticalSpace(0.01),
        Row(
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
        ),
      ],
    );
  }
}
