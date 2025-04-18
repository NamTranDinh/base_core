import 'package:flutter/material.dart';

abstract class MenuItemValue {
  String valueItem();

  String idItem();
}

abstract class BaseColors {
  MaterialColor get primary;

  MaterialColor get warning;

  MaterialColor get success;

  MaterialColor get error;
}
