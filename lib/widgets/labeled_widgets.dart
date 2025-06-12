import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'dropdown_selector.dart';

class LabeledSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final String instruction;
  final Function(String? newValue) onSelectionChange;
  final InputDecoration? decoration;
  const LabeledSelector({
    super.key,
    required this.title,
    required this.options,
    required this.instruction,
    required this.onSelectionChange,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledWidget(
      title: title,
      widget: DropDownSelector(
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
