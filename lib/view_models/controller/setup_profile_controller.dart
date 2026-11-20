import 'package:get/get.dart';
import '../../res/routes/routes_names.dart';
import '../../utils/utils.dart';
import '../services/setup_profile_service.dart';
import 'base_controller.dart';

class SetupProfileController extends GetxController with BaseController {
  final SetupProfileService setupProfileService = SetupProfileService();
  final categories = <Map<String, dynamic>>[].obs;
  final selectedCategoryIds = <int>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      final response = await setupProfileService.getCategoriesApi();
      categories.assignAll((response as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getCategories);
    }
  }

  void toggleCategory(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
  }

  Future<void> saveProfile({required String fullName, required String city, required int experience}) async {
    try {
      isLoading.value = true;
      await setupProfileService.saveProfileApi({
        'full_name': fullName,
        'city': city,
        'experience_years': experience,
        'skill_categories': selectedCategoryIds.toList(),
      });
      isLoading.value = false;
      Utils.successToast('Profile setup completed');
      Get.offAllNamed(RouteName.dashboardScreen);
    } catch (e) {
      isLoading.value = false;
      handleError(e);
    }
  }
}
