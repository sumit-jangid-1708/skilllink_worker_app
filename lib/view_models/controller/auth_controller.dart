import 'package:get/get.dart';
import '../../data/storage/app_storage.dart';
import '../../models/send_otp_model.dart';
import '../../models/verify_otp_model.dart';
import '../../data/app_exceptions.dart';
import '../../utils/utils.dart';
import '../services/auth_service.dart';
import 'base_controller.dart';

class AuthController extends GetxController with BaseController {
  final AuthService authService = AuthService();

  var isLoading = false.obs;

  // Send OTP Model variable
  final sendOtpModel = Rxn<SendOtpModel>();
  final verifyOtpModel = Rxn<VerifyOtpResponseModel>();

  void sendOtp(String phoneNumber) async {
    try {
      isLoading.value = true;
      Map data = {
        'phone_number': phoneNumber,
      };
      final response = await authService.sendOtpApi(data);
      sendOtpModel.value = SendOtpModel.fromJson(response);

      isLoading.value = false;
      print(response);
      // Show success toast
      Utils.successToast(sendOtpModel.value?.message ?? "OTP sent successfully");

    } catch (e) {
      isLoading.value = false;
      handleError(e, onRetry: () => sendOtp(phoneNumber));
    }
  }

  void verifyOtp(String phoneNumber, String otp) async {
    try {
      isLoading.value = true;
      Map data = {
        "phone_number": phoneNumber,
        "code": otp,
        "role": "technician"
      };
      final response = await authService.verifyOtpApi(data);
      VerifyOtpResponseModel model = VerifyOtpResponseModel.fromJson(response);

      if (model.tokens.access.isEmpty) {
        throw FetchDataException("Authentication failed: No access token received");
      }

      // Save both access and refresh tokens
      await AppStorage.saveToken(model.tokens.access, refresh: model.tokens.refresh);

      isLoading.value = false;
      verifyOtpModel.value = model;
    } catch (e) {
      isLoading.value = false;
      print("Error in verifyOtp: $e");
      handleError(e, onRetry: () => verifyOtp(phoneNumber, otp));
    }
  }
}
