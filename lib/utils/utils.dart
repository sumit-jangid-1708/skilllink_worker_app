import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/colors/app_colors.dart';


class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.grey400.withOpacity(0.9),
      textColor: AppColor.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static successToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.success.withOpacity(0.9),
      textColor: AppColor.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.grey400.withOpacity(0.9),
      textColor: AppColor.white,
      gravity: ToastGravity.CENTER,
    );
  }

  static bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email.trim());
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColor.primary.withOpacity(0.1),
      colorText: AppColor.textPrimary,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
  }
}
