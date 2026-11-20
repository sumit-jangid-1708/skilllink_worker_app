import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class HomeService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getDashboardApi() async => await _apiServices.getApi(AppUrl.technicianDashboard);
  Future<dynamic> getProfileApi() async => await _apiServices.getApi(AppUrl.technicianProfile);
  Future<dynamic> getIncomingRequestsApi() async => await _apiServices.getApi(AppUrl.technicianIncoming);

  Future<dynamic> acceptJobApi(int id) async =>
      await _apiServices.postApi({}, AppUrl.acceptJob(id), requiresAuth: true);

  Future<dynamic> rejectJobApi(int id) async =>
      await _apiServices.postApi({}, AppUrl.rejectJob(id), requiresAuth: true);

  Future<dynamic> updateAvailabilityApi(bool value) async =>
      await _apiServices.patchApi({'is_available': value}, AppUrl.technicianProfile);
}
