import 'dart:async';
import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../res/routes/routes_names.dart';

class SplashController extends GetxController {
  
  @override
  void onInit() {
    super.onInit();
    // 3 seconds ka wait karein phir navigate karein
    Timer(const Duration(seconds: 3), () {
      _navigateToNext();
    });
  }

  void _navigateToNext() {
    try {
      // Check if user is already logged in
      if (AppStorage.hasToken()) {
        Get.offAllNamed(RouteName.dashboardScreen);
      } else {
        Get.offAllNamed(RouteName.loginScreen);
      }
    } catch (e) {
      // Kisi bhi error ki surat mein Login screen par bhej dein
      Get.offAllNamed(RouteName.loginScreen);
    }
  }
}
