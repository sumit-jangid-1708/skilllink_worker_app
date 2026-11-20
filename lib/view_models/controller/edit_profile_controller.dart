import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../services/edit_profile_service.dart';
import 'base_controller.dart';

class EditProfileController extends GetxController with BaseController {
  final EditProfileService editProfileService = EditProfileService();
  final profile = <String, dynamic>{}.obs;
  final categories = <Map<String, dynamic>>[].obs;
  final selectedCategoryIds = <int>[].obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  @override
  void onReady() {
    super.onReady();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        editProfileService.getProfileApi(),
        editProfileService.getCategoriesApi(),
      ]);
      profile.assignAll(Map<String, dynamic>.from(results[0] as Map));
      categories.assignAll((results[1] as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList());
      selectedCategoryIds.assignAll((profile['skill_categories'] as List? ?? [])
          .map((item) => int.tryParse('$item') ?? -1)
          .where((id) => id > 0)
          .toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getProfileData);
    }
  }

  void toggleCategory(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
  }

  Future<void> updateProfile({required String fullName, required String city, required int experience}) async {
    try {
      isSaving.value = true;
      final response = await editProfileService.updateProfileApi({
        'full_name': fullName,
        'city': city,
        'experience_years': experience,
        'skill_categories': selectedCategoryIds.toList(),
      });
      profile.assignAll(Map<String, dynamic>.from(response as Map));
      isSaving.value = false;
      Utils.successToast('Profile updated');
      Get.back();
    } catch (e) {
      isSaving.value = false;
      handleError(e);
    }
  }
}
