import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

import '../models/core_models.dart';

GetStorage get storage => GetStorage();

InputDecoration getInputDecoration(String hint, {bool fill = false}) =>
    InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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

IconData getPropertyIcon(String typeString) {
  PropertyType type = PropertyType.values.byName(typeString);
  return type == PropertyType.Motorcycle
      ? FontAwesomeIcons.motorcycle
      : type == PropertyType.Tricycle
          ? FontAwesomeIcons.bicycle
          : type == PropertyType.Car
              ? FontAwesomeIcons.car
              : type == PropertyType.Truck
                  ? FontAwesomeIcons.truck
                  : FontAwesomeIcons.tractor;
}
