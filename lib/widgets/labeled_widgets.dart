import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../shared/constants.dart';
import 'dropdown_selector.dart';

class LabeledSwitch extends StatelessWidget {
  final String title;
  final String? switchTitle;
  final String? switchSubTitle;
  final RxBool currentValue;

  final Function(bool newValue)? onChange;

  const LabeledSwitch({
    super.key,
    required this.title,
    this.switchSubTitle,
    this.switchTitle,
    this.onChange,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      title: title,
      widget: Obx(
        () => SwitchListTile(
          // tileColor: Colors.red,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: kPurpleColor),
              borderRadius: BorderRadius.circular(8)),
          activeColor: kPurpleColor,
          title: switchTitle != null ? Text(switchTitle!) : null,
          subtitle: switchSubTitle != null ? Text(switchSubTitle!) : null,
          // const Text('Is Property managed'),
          // subtitle:
          //     const Text('Are you managing this property for a third party ?'),
          value: currentValue.value,
          onChanged: (bool? value) {
            currentValue.value = value ?? false;
            if (onChange != null) onChange!(value ?? false);
          },
        ),
      ),
    );
  }
}

class LabeledSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final String instruction;
  final Function(String? newValue) onSelectionChange;
  final InputDecoration? decoration;
  final int? selectedIndex;
  const LabeledSelector({
    super.key,
    required this.title,
    required this.options,
    required this.instruction,
    required this.onSelectionChange,
    this.decoration,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      title: title,
      widget: DropDownSelector(
        selectedIndex: selectedIndex ?? -1,
        list: options,
        onSelectionChange: onSelectionChange,
        instruction: instruction,
        inputDecoration: decoration,
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool readOnly;
  final String? Function(String? value)? validator;
  const LabeledTextField(
      {super.key,
      required this.title,
      this.validator,
      this.controller,
      this.inputType,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      title: title,
      widget: TextFormField(
        readOnly: readOnly,
        decoration: InputDecoration(
          enabledBorder: purpleBorder,
          focusedBorder: purpleBorder,
          border: purpleBorder,
        ),
        validator: validator,
        controller: controller,
        keyboardType: inputType,
      ),
    );
  }
}

class LabeledWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final bool isVertical;
  const LabeledWidget({
    super.key,
    required this.title,
    required this.widget,
    this.isVertical = true,
  });

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: kPurpleTextStyle),
              widget,
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget,
              Text(title, style: kPurpleTextStyle),
            ],
          );
  }
}
