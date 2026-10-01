class VerifyOtpResponseModel {
  final String message;
  final UserModel user;
  final TokensModel tokens;
  final bool isNewUser;

  VerifyOtpResponseModel({
    required this.message,
    required this.user,
    required this.tokens,
    required this.isNewUser,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      message: json['message'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      tokens: TokensModel.fromJson(json['tokens'] ?? {}),
      isNewUser: json['is_new_user'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
      'tokens': tokens.toJson(),
      'is_new_user': isNewUser,
    };
  }
}

class UserModel {
  final int id;
  final String phoneNumber;
  final String role;
  final bool isActive;
  final String createdAt;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      phoneNumber: json['phone_number'] ?? '',
      role: json['role'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'role': role,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }
}

class TokensModel {
  final String refresh;
  final String access;

  TokensModel({
    required this.refresh,
    required this.access,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      refresh: json['refresh'] ?? '',
      access: json['access'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
      'access': access,
    };
  }
}