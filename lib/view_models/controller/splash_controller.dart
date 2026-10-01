import 'dart:async';
import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../res/routes/routes_names.dart';
import 'base_controller.dart';

class SplashController extends GetxController with BaseController {
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    // Navigate after 3 seconds without waiting for API
    _timer = Timer(const Duration(seconds: 3), checkSession);
  }

  void checkSession() {
    if (isClosed) return;

    // Just check if token exists locally to avoid splash screen hangs
    if (AppStorage.hasToken()) {
      Get.offAllNamed(RouteName.dashboardScreen);
    } else {
      Get.offAllNamed(RouteName.loginScreen);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
