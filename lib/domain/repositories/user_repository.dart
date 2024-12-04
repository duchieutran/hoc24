import 'dart:async';

import 'package:get/get.dart';
import 'package:hoc24/app/storage/app_storage.dart';
import 'package:hoc24/data/providers/network/apis/rest_client.dart';
import 'package:hoc24/data/providers/network/apis/services/user_service.dart';
import 'package:hoc24/domain/models/request/user/login_request.dart';
import 'package:hoc24/domain/models/request/user/logout_request.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';

import '../models/response/user/auth_entity.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  final _userService = Get.find<UserService>();
  final storage = Get.find<AppStorage>();

  Future<void> logOut(LogoutRequest data) => _userService.logOut(data);

  Future<AuthEntity?> login(LoginRequest data) async {
    final response = await _userService.login(data);
    await saveToken(response);
    return response;
  }

  Future<void> saveToken(AuthEntity? authEntity) async {
    if (authEntity == null || authEntity.accessToken == null) return;
    RestClient.instance.setToken(authEntity.accessToken!);
    await storage.saveToken(authEntity.accessToken!);
    final appController = Get.find<AppController>();
    appController.isLoggedIn = true;
    appController.updateAccessToken(authEntity.accessToken!);
    appController.updateUserInfo(authEntity.userEntity!);
  }
}
