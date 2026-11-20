import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class JobDetailsService {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getRequestApi(int id) async =>
      await _apiServices.getApi(AppUrl.requestDetail(id));

  Future<dynamic> acceptJobApi(int id) async =>
      await _apiServices.postApi({}, AppUrl.acceptJob(id), requiresAuth: true);

  Future<dynamic> rejectJobApi(int id) async =>
      await _apiServices.postApi({}, AppUrl.rejectJob(id), requiresAuth: true);

  Future<dynamic> updateStatusApi(int id, String status) async =>
      await _apiServices.patchApi({'status': status}, AppUrl.updateJobStatus(id));

  Future<dynamic> uploadPhotosApi(int id, Map<String, String> files) async =>
      await _apiServices.multipartApi('PATCH', {}, AppUrl.uploadJobPhotos(id), files);
}
