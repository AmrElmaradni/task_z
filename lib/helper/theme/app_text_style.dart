import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const TextStyle appBarStyle = TextStyle(
    color: AppColor.appBarTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'poppins',
  );

  static const TextStyle buttonStyle = TextStyle(
    color: AppColor.buttonTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle hintStyle = TextStyle(
    color: AppColor.hintColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textFormStyle = TextStyle(
    color: AppColor.formFieldTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textD16B = TextStyle(
    color: AppColor.darkTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textW14M = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
