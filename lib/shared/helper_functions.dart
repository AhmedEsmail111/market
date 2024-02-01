import 'package:flutter/material.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';

class HelperFunctions {
  static pushScreen(context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => screen),
      ),
    );
  }

  static pussAndRemoveAll(context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: ((context) => screen),
      ),
      (rout) => false,
    );
  }

  static bool isTextEnglish(String text) {
    for (int i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);

      // Check if the character is in the Arabic script range
      if (charCode >= 0x0600 && charCode <= 0x06FF) {
        return false;
      }
    }

    return true;
  }

  static bool isLocaleEnglish() {
    return CacheHelper.getData(key: languageKey) != 'ar';
  }
}
