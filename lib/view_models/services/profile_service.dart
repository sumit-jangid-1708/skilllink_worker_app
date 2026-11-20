import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class ProfileService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getProfileApi() async => await _apiServices.getApi(AppUrl.technicianProfile);
  Future<dynamic> getDashboardApi() async => await _apiServices.getApi(AppUrl.technicianDashboard);
  Future<dynamic> getCategoriesApi() async => await _apiServices.getApi(AppUrl.categories);

  Future<dynamic> updateProfileApi(Map data) async =>
      await _apiServices.patchApi(data, AppUrl.technicianProfile);
}
