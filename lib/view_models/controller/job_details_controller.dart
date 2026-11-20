import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../services/job_details_service.dart';
import 'base_controller.dart';
import 'home_controller.dart';

class JobDetailsController extends GetxController with BaseController {
  final JobDetailsService jobDetailsService = JobDetailsService();
  final request = <String, dynamic>{}.obs;
  final isLoading = false.obs;
  final isActionLoading = false.obs;
  int requestId = 0;

  @override
  void onReady() {
    super.onReady();
    final arguments = Get.arguments;
    if (arguments is Map) {
      requestId = int.tryParse('${arguments['id'] ?? arguments['request_id'] ?? ''}') ?? 0;
      if (arguments['request'] is Map) {
        request.assignAll(Map<String, dynamic>.from(arguments['request'] as Map));
      }
    }
    if (requestId > 0 && request['status'] != 'pending') getRequest();
  }

  Future<void> getRequest() async {
    try {
      isLoading.value = true;
      final response = await jobDetailsService.getRequestApi(requestId);
      request.assignAll(Map<String, dynamic>.from(response as Map));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getRequest);
    }
  }

  Future<void> acceptJob() async =>
      await _runAction(() => jobDetailsService.acceptJobApi(requestId), 'Job accepted');

  Future<void> rejectJob() async =>
      await _runAction(() => jobDetailsService.rejectJobApi(requestId), 'Job rejected');

  Future<void> updateStatus(String status) async {
    await _runAction(
      () => jobDetailsService.updateStatusApi(requestId, status),
      status == 'completed' ? 'Job completed' : 'Job started',
    );
  }

  Future<void> uploadPhotos(Map<String, String> files) async =>
      await _runAction(() => jobDetailsService.uploadPhotosApi(requestId, files), 'Photos uploaded');

  Future<void> _runAction(Future<dynamic> Function() action, String message) async {
    try {
      isActionLoading.value = true;
      final response = await action();
      if (response is Map && response.containsKey('id')) {
        request.assignAll(Map<String, dynamic>.from(response));
      }
      isActionLoading.value = false;
      Utils.successToast(message);
      if (message == 'Job accepted' || message == 'Job rejected') {
        if (Get.isRegistered<HomeController>()) {
          final home = Get.find<HomeController>();
          if (message == 'Job rejected') {
            home.removeIncomingRequest(requestId);
          } else {
            home.getHomeData();
          }
        }
        Get.back();
      }
    } catch (e) {
      isActionLoading.value = false;
      handleError(e);
    }
  }
}
