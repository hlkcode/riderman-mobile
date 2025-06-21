import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tools/ui/widgets.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/auth_controller.dart';
import '../shared/constants.dart';

class VerificationPage extends StatelessWidget {
  static const String routeName = '/VerificationPage';

  VerificationPage({
    super.key,
    required this.nextPage,
    required this.phoneNumber,
  });
  final String nextPage;
  final String phoneNumber;
  final RxString timeText = '00:00'.obs;
  final RxBool canResend = false.obs;
  final AuthController authController = Get.find();

  Timer? _timer, _timer2;
  void _cancelTimer() {
    _timer?.cancel();
    _timer2?.cancel();
    _timer = null;
    _timer2 = null;
  }

  void initRapidConnectCounter() async {
    var start = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var dur = DateTime.now().difference(start);
      timeText.value = dur.toString().split('.').first.substring(2, 7);
      _timer2 = timer;
      if (dur.inMinutes >= 2) {
        _cancelTimer();
        canResend.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initRapidConnectCounter();
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

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );

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
          Center(
            child: Obx(() => Text(timeText.value, style: kPurpleTextStyle)),
          ),
          verticalSpace(0.06),
          const Text(
            'A verification code has been sent to you, please enter it here.',
            style: TextStyle(fontSize: 16),
          ),
          verticalSpace(0.02),
          Obx(
            () => TextButton(
              onPressed: canResend.value
                  ? () async {
                      await authController.getCode(phoneNumber);
                      initRapidConnectCounter();
                    }
                  : null,
              child: Text(
                'I didn\'t receive the code! Send Again',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  color: canResend.value ? kPurpleColor : Colors.grey,
                ),
              ),
            ),
          ),
          verticalSpace(0.1),
          Obx(
            () => LoadingButton(
              // buttonHeight: getHeight(0.06),
              text: 'Verify',
              isLoading: authController.loading.value,
              buttonColor: kPurpleColor,
              style: kWhiteTextStyle,
              buttonRadius: 12,
              onTapped: () async {
                if (code.length != 5 || code.isNumericOnly == false) {
                  HlkDialog.showErrorSnackBar('Enter a valid code please');
                  return;
                }
                var isGood = await authController.verify(phoneNumber, code);
                if (isGood == false) return;
                _cancelTimer();
                if (authController.canTempUserLogin) {
                  await authController.autoLogin();
                } else {
                  Get.offAllNamed(nextPage);
                }
              },
            ),
          ),
        ],
      ).marginSymmetric(horizontal: 12),
    );
  }
}
