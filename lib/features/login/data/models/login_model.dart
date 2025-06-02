import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  LoginModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  final int statusCode;
  final String message;
  final LoginData data;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class LoginData {
  LoginData({required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  final String token;

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class UserInfo {
  UserInfo({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.permissions,
    this.dob,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  final int id;
  final String username;
  final String fullName;
  final String role;
  final List<String> permissions;
  final String? dob;

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class JwtPayload {
  JwtPayload({
    required this.iss,
    required this.sub,
    required this.exp,
    required this.iat,
    required this.user,
  });

  factory JwtPayload.fromJson(Map<String, dynamic> json) =>
      _$JwtPayloadFromJson(json);

  final String iss;
  final String sub;
  final int exp;
  final int iat;
  final UserInfo user;

  Map<String, dynamic> toJson() => _$JwtPayloadToJson(this);
}
