import 'package:get/get.dart';
import '../services/jobs_service.dart';
import 'base_controller.dart';

class JobsController extends GetxController with BaseController {
  final JobsService jobsService = JobsService();
  // Filter options: 'All', 'This Week', 'This Month'
  var selectedFilter = 'All'.obs;
  final jobs = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    getJobs();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    getJobs();
  }

  Future<void> getJobs() async {
    try {
      isLoading.value = true;
      final filter = selectedFilter.value == 'This Week'
          ? 'this_week'
          : selectedFilter.value == 'This Month'
              ? 'this_month'
              : '';
      final response = await jobsService.getHistoryApi(filter);
      jobs.assignAll((response as List)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: getJobs);
    }
  }
}
