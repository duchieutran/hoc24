import 'package:hoc24/domain/models/response/user/user_entity.dart';

class AuthEntity {
  UserEntity? userEntity;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  @override
  String toString() {
    return 'AuthEntity{accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn}';
  }

  AuthEntity({
    this.userEntity,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
        userEntity: json["user"] == null ? null : UserEntity.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "user": userEntity?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
      };
}
