import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../res/routes/routes_names.dart';
import '../../utils/utils.dart';
import '../services/profile_service.dart';
import 'base_controller.dart';

class ProfileController extends GetxController with BaseController {
  final ProfileService profileService = ProfileService();
  final profile = <String, dynamic>{}.obs;
  final dashboard = <String, dynamic>{}.obs;
  final categories = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        profileService.getProfileApi(),
        profileService.getDashboardApi(),
        profileService.getCategoriesApi(),
      ]);
      profile.assignAll(Map<String, dynamic>.from(results[0] as Map));
      dashboard.assignAll(Map<String, dynamic>.from(results[1] as Map));
      categories.assignAll((results[2] as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getProfile);
    }
  }

  Future<void> updateAvailability(bool value) async {
    try {
      final response = await profileService.updateProfileApi({'is_available': value});
      profile.assignAll(Map<String, dynamic>.from(response as Map));
      Utils.successToast(value ? 'You are online' : 'You are offline');
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> logout() async {
    await AppStorage.removeToken();
    Get.offAllNamed(RouteName.loginScreen);
  }
}
