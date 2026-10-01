import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class AuthService{
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> sendOtpApi(data) async{
    dynamic response = await _apiServices.postApi(data, AppUrl.sendOtp);
    return response;
  }

  Future<dynamic> verifyOtpApi(data)async{
    dynamic response = await _apiServices.postApi(data, AppUrl.verifyOtp);
    return response;
  }

}