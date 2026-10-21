import 'package:get/get.dart';

class JobsController extends GetxController {
  // Filter status: 'Active', 'Pending', 'Complete'
  var selectedFilter = 'Active'.obs;

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
