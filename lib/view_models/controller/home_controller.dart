import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../services/home_service.dart';
import 'base_controller.dart';

class HomeController extends GetxController with BaseController {
  final HomeService homeService = HomeService();
  final dashboard = <String, dynamic>{}.obs;
  final profile = <String, dynamic>{}.obs;
  final incomingRequests = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final isActionLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getHomeData();
  }

  Future<void> getHomeData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        homeService.getDashboardApi(),
        homeService.getProfileApi(),
        homeService.getIncomingRequestsApi(),
      ]);
      dashboard.assignAll(Map<String, dynamic>.from(results[0] as Map));
      profile.assignAll(Map<String, dynamic>.from(results[1] as Map));
      incomingRequests.assignAll(
        (results[2] as List).map((item) => Map<String, dynamic>.from(item as Map)).toList(),
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getHomeData);
    }
  }

  Future<void> acceptJob(int id) async {
    try {
      isActionLoading.value = true;
      await homeService.acceptJobApi(id);
      isActionLoading.value = false;
      Utils.successToast('Job accepted');
      await getHomeData();
    } catch (e) {
      isActionLoading.value = false;
      handleError(e);
    }
  }

  Future<void> rejectJob(int id) async {
    try {
      isActionLoading.value = true;
      await homeService.rejectJobApi(id);
      removeIncomingRequest(id);
      isActionLoading.value = false;
      Utils.successToast('Job rejected');
    } catch (e) {
      isActionLoading.value = false;
      handleError(e);
    }
  }

  void removeIncomingRequest(int id) {
    incomingRequests.removeWhere((job) => int.tryParse('${job['id']}') == id);
  }

  Future<void> updateAvailability(bool value) async {
    try {
      final response = await homeService.updateAvailabilityApi(value);
      profile.assignAll(Map<String, dynamic>.from(response as Map));
      Utils.successToast(value ? 'You are online' : 'You are offline');
    } catch (e) {
      handleError(e);
      await getHomeData();
    }
  }
}
