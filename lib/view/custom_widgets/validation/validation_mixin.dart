import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../helper/locale/app_locale_key.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String? validatePhone(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validatePhone);
    } else if (value.startsWith('0')) {
      return tr(AppLocaleKey.validatePhoneStartWithZero);
    } else if (value.trim().length != 10) {
      return tr(
        AppLocaleKey.validatePhoneContainTenNumbers,
        args: [
          '10',
        ],
      );
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.trim().length < 8) {
      return tr(AppLocaleKey.validatePassword);
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateName);
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return tr(AppLocaleKey.validateEmail);
    } else if (!_emailValidationStructure(value.trim())) {
      return tr(AppLocaleKey.validateEmailStructure);
    }
    return null;
  }

  bool _emailValidationStructure(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
