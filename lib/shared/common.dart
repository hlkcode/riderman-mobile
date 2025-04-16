import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

GetStorage get storage => GetStorage();

InputDecoration getInputDecoration(String hint, {bool fill = false}) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      // hintText: hint,
      labelText: hint,
      filled: fill,
    );

InputDecoration getInputDecorationNoBorder(String hint,
        {bool fill = false, TextStyle? style}) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      hintText: hint,
      hintStyle: style,
      filled: fill,
    );
