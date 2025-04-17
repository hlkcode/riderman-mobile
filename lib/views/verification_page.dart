import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../shared/constants.dart';

class VerificationPage extends StatelessWidget {
  static const String routeName = '/VerificationPage';

  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var code = '';
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 24,
        // color: Color.fromRGBO(30, 60, 87, 1),
        // fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: kPurpleColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      // backgroundColor: kPurpleLightColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text('Verification'),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(0.04),
          const Text(
            'Enter your Verification Code',
            style: TextStyle(fontSize: 32),
          ),
          verticalSpace(0.06),
          Center(
            child: Pinput(
              length: 5,
              defaultPinTheme: defaultPinTheme,
              // focusedPinTheme: focusedPinTheme,
              // submittedPinTheme: submittedPinTheme,
              // validator: (s) {
              //   return s == '2222' ? null : 'Pin is incorrect';
              // },
              // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              // showCursor: true,
              onCompleted: (pin) {
                code = pin;
                logInfo(code);
              },
              separatorBuilder: (s) => horizontalSpace(0.04),
            ),
          ),
          verticalSpace(0.06),
          const Text(
            'A verification code has been sent to you, please enter it here.',
            style: TextStyle(fontSize: 16),
          ),
          verticalSpace(0.02),
          TextButton(
            onPressed: () {},
            child: const Text(
              'I didn\'t receive the code! Send Again',
              style: TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: kPurpleColor,
              ),
            ),
          ),
          verticalSpace(0.1),
          LoadingButton(
            // buttonHeight: getHeight(0.06),
            text: 'Verify',
            isLoading: false,
            buttonColor: kPurpleColor,
            style: kWhiteTextStyle,
            buttonRadius: 12,
            onTapped: () {},
          ),
        ],
      ).marginSymmetric(horizontal: 12),
    );
  }
}
