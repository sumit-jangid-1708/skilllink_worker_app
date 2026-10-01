class SendOtpModel {
  String? message;
  String? phoneNumber;
  String? otp;

  SendOtpModel({this.message, this.phoneNumber, this.otp});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    phoneNumber = json['phone_number'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['phone_number'] = phoneNumber;
    data['otp'] = otp;
    return data;
  }
}
