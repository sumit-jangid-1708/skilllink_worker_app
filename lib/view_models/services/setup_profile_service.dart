import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class SetupProfileService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getCategoriesApi() async => await _apiServices.getApi(AppUrl.categories);
  Future<dynamic> saveProfileApi(Map data) async =>
      await _apiServices.patchApi(data, AppUrl.technicianProfile);
}
