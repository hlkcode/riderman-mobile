import 'package:flutter/material.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class DropDownSelector extends StatelessWidget {
  const DropDownSelector(
      {super.key,
      required this.list,
      required this.onSelectionChange,
      required this.instruction,
      required});

  final List<String> list;
  final Function(String? newValue) onSelectionChange;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        hint: Align(
          child: Text(
            getString(GetUtils.capitalize(instruction)),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        validator: requiredValidator,
        items: list.map((String value) {
          return DropdownMenuItem<String>(
            alignment: AlignmentDirectional.center,
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onSelectionChange,
      ),
    );
  }
}
