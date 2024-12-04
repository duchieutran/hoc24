import 'dart:async';

import 'package:hoc24/data/providers/network/apis/api_constants.dart';
import 'package:hoc24/domain/models/request/user/login_request.dart';
import 'package:hoc24/domain/models/request/user/logout_request.dart';
import 'package:hoc24/domain/models/response/user/auth_entity.dart';

import 'base_service.dart';

class UserService extends BaseService {
  Future<AuthEntity> login(LoginRequest data) async {
    final response = await post(LOGIN, data: data.toJson(), responseType: JsonType.FULL_RESPONSE);
    return AuthEntity.fromJson(response);
  }

  Future<void> logOut(LogoutRequest data) => delete(LOGIN, data: data.toJson());
}
