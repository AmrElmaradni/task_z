import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

ThemeData appThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: AppColor.mainAppColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    hintColor: AppColor.hintColor,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.mainAppColor,
      alignedDropdown: true,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.mainAppColor,
      secondary: AppColor.secondAppColor,
      background: AppColor.whiteColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColor.secondAppColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyle.appBarStyle,
    ),
    scaffoldBackgroundColor: AppColor.scaffoldColor,
    fontFamily: 'poppins',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.mainAppColor,
    ),
    platform: TargetPlatform.iOS,
  );
}
