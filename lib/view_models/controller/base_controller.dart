import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/app_exceptions.dart';
import '../../data/storage/app_storage.dart';
import '../../res/components/widgets/custom_error_dialog.dart';
import '../../res/routes/routes_names.dart';

mixin BaseController {
  void handleError(dynamic error, {VoidCallback? onRetry}) {
    if (Get.isDialogOpen ?? false) return;

    String title = "Error";
    String message = "Something went wrong. Please try again.";
    IconData icon = Icons.error_outline_rounded;
    Color color = Colors.red;
    bool isAuthError = false;

    if (error is InternetExceptions) {
      title = "No Internet";
      message = "Please check your internet connection and try again.";
      icon = Icons.wifi_off_rounded;
      color = Colors.orange;
    } else if (error is RequestTimeOut) {
      title = "Connection Slow";
      message = "Your connection is slow or the server took too long.";
      icon = Icons.signal_wifi_statusbar_connected_no_internet_4_rounded;
      color = Colors.orange.shade700;
    } else if (error is UnauthorizedException) {
      // ✅ Session Expired logic
      title = "Session Expired";
      message = "Your session has expired. Please login again to continue.";
      icon = Icons.lock_outline_rounded;
      color = Colors.blue;
      isAuthError = true;
    } else if (error is ServerException) {
      title = "Server Error";
      message = error.toString().contains("Server is not responding")
          ? "Server is not responding. Please try again later."
          : error.toString();
      icon = Icons.dns_rounded;
      color = Colors.red;
    } else if (error is AppExceptions) {
      title = "Error";
      message = error.toString();
      icon = Icons.info_outline_rounded;
      color = Colors.red;
    }

    Get.dialog(
      CustomErrorDialog(
        title: title,
        message: message,
        icon: icon,
        color: color,
        onRetry: isAuthError ? null : onRetry,
        // If it's an auth error, change the button text to 'Login'
        buttonText: isAuthError ? "Go to Login" : "Retry",
        onTap: () async {
          if (isAuthError) {
            await AppStorage.removeToken();
            Get.offAllNamed(RouteName.loginScreen);
          } else {
            Get.back(); // Close dialog
            if (onRetry != null) onRetry();
          }
        },
      ),
      barrierDismissible: !isAuthError,
    );
  }
}
