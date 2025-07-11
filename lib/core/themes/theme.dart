import 'package:flutter/material.dart';
import 'package:store_demo/core/themes/customs_themes/appbar_theme.dart';
import 'package:store_demo/core/themes/customs_themes/bottom_sheet_theme.dart';
import 'package:store_demo/core/themes/customs_themes/checkbox_theme.dart';
import 'package:store_demo/core/themes/customs_themes/chip_theme.dart';
import 'package:store_demo/core/themes/customs_themes/elevated_button_theme.dart';
import 'package:store_demo/core/themes/customs_themes/outlined_button_theme.dart';
import 'package:store_demo/core/themes/customs_themes/text_button_theme.dart';
import 'package:store_demo/core/themes/customs_themes/text_field.dart';
import 'package:store_demo/core/themes/customs_themes/text_theme.dart';
import 'package:store_demo/core/utils/constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Gotham',
      brightness: Brightness.light,
      primaryColor: TColors.primary,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightTheme,
      chipTheme: TChipTheme.lightTheme,
      bottomSheetTheme: TBottomSheetTheme.lightTheme,
      appBarTheme: TAppbarTheme.lightTheme,
      inputDecorationTheme: TTextFormField.lightTheme,
      checkboxTheme: TCheckboxTheme.lightTheme,
      textButtonTheme: TTextButtonTheme.lightTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Gotham',
      brightness: Brightness.dark,
      primaryColor: TColors.primary,
      scaffoldBackgroundColor: TColors.black,
      textTheme: TTextTheme.darkTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
      chipTheme: TChipTheme.darkTheme,
      bottomSheetTheme: TBottomSheetTheme.darkTheme,
      appBarTheme: TAppbarTheme.darkTheme,
      inputDecorationTheme: TTextFormField.darkTheme,
      checkboxTheme: TCheckboxTheme.darkTheme,
      textButtonTheme: TTextButtonTheme.darkTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkTheme);
}
