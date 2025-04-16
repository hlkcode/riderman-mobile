import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../shared/constants.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = '/WelcomePage';
  const WelcomePage({super.key});

  final pageDecor = const PageDecoration(
    // titleTextStyle: TextStyle(color: Colors.orange),
    titleTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 24.0),
    imageFlex: 2,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(0.04),
            Expanded(
              child: IntroductionScreen(
                // 2. Pass that key to the `IntroductionScreen` `key` param
                // key: _introKey,
                pages: [
                  PageViewModel(
                    title: "Gain total control of your money",
                    body:
                        "Become your own rider manager and make every pen count",
                    image: Center(
                      child: Image.asset('assets/images/Money in hand.png'),
                    ),
                    decoration: pageDecor,
                  ),
                  PageViewModel(
                    title: "Know where your money goes",
                    body:
                        "Track your money easily, with categories and financial reports",
                    image: Center(
                      child: Image.asset('assets/images/Bill with money.png'),
                    ),
                    decoration: pageDecor,
                  ),
                  PageViewModel(
                    title: "Planning ahead",
                    body:
                        "Setup your estimations for each category so you are in control",
                    image: Center(
                      child: Image.asset('assets/images/Clip board.png'),
                    ),
                    decoration: pageDecor,
                  ),
                ],
                showNextButton: false,
                showDoneButton: false,
                dotsDecorator: const DotsDecorator(
                  activeColor: kPurpleColor,
                  activeSize: Size(16, 16),
                ),
              ).marginSymmetric(horizontal: 12, vertical: 12),
            ),
            LoadingButton(
              text: 'Sign Up',
              isLoading: false,
              buttonColor: kPurpleColor,
              style: const TextStyle(color: Colors.white),
              buttonRadius: 12,
              onTapped: () {},
            ).marginSymmetric(horizontal: 10, vertical: 10),
            LoadingButton(
              text: 'Login',
              isLoading: false,
              buttonColor: kPurpleLightColor,
              style: const TextStyle(color: kPurpleColor),
              buttonRadius: 12,
              onTapped: () {},
            ).marginSymmetric(horizontal: 10, vertical: 10),
          ],
        ).marginSymmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
