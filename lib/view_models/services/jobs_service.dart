import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class JobsService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getHistoryApi(String filter) async {
    final url = filter.isEmpty
        ? AppUrl.technicianHistory
        : '${AppUrl.technicianHistory}?filter=$filter';
    return await _apiServices.getApi(url);
  }
}
