import 'package:flutter/material.dart';
import 'package:store_demo/core/utils/constants/colors.dart';

class TAppbarTheme {
  TAppbarTheme._();

  static const lightTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(fontFamily: "Gotham", fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black),
  );

  static const darkTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(fontFamily: "Gotham", fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
