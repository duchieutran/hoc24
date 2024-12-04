// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

class AppStorage {
  late GetStorage box;
  static const STORAGE_NAME = 'hoc24_storage';
  static const USER_TOKEN = 'user_token';
  static const USER_INFO = 'user_info';
  static const USERNAME_PASSWORD = 'username_password';
  static const DARK_MODE = 'dark-mode';

  init() async {
    await GetStorage.init(STORAGE_NAME);
    box = GetStorage(STORAGE_NAME);
  }

  Future<void> saveUserInfo(UserEntity user) async {
    String json = jsonEncode(user.toJson());
    box.write(USER_INFO, json);
  }

  Future<UserEntity?> getUserInfo() async {
    final userJson = await box.read(USER_INFO);
    return userJson != null ? UserEntity.fromJson(json.decode(userJson)) : null;
  }

  Future<void> saveToken(String refreshToken) async {
    box.write(USER_TOKEN, refreshToken);
  }

  Future<String?> getToken() async {
    final token = await box.read(USER_TOKEN);
    return token;
  }

  Future<void> saveUsernameAndPasswordToLocal({required String username, required String password}) async {
    String json = jsonEncode({'username': username, 'password': password});
    box.write(USERNAME_PASSWORD, json);
  }

  Future<Map<String, dynamic>?> getUsernamePasswordFromLocal() async {
    final usernameAndPassword = await box.read(USERNAME_PASSWORD);
    if (usernameAndPassword != null) {
      return jsonDecode(usernameAndPassword);
    }
    return null;
  }

  Future<void> removeUsernameAndPasswordFromLocal() async {
    if (box.hasData(USERNAME_PASSWORD)) await box.remove(USERNAME_PASSWORD);
  }

  Future<void> saveDarkMode(String darkMode) async {
    box.write(DARK_MODE, darkMode);
  }

  Future<String?> getDarkMode() async {
    final darkMode = await box.read(DARK_MODE);
    return darkMode;
  }

  Future<void> logout() async {
    if (box.hasData(USER_TOKEN)) await box.remove(USER_TOKEN);
    if (box.hasData(USER_INFO)) await box.remove(USER_INFO);
  }

  Future<void> deleteMemo() async {
    if (box.hasData(USERNAME_PASSWORD)) await box.remove(USERNAME_PASSWORD);
  }
}
