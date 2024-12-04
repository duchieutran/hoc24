import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/request/user/login_request.dart';
import 'package:hoc24/domain/repositories/user_repository.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:http/http.dart' as http;

class LoginController extends BaseController {
  final userRepository = Get.find<UserRepository>();
  final formKeySignIn = GlobalKey<FormState>();
  final formKeyForgetPassword = GlobalKey<FormState>();

  //Login with Email/Password
  Rx<bool> passwordVisible = false.obs;
  Rx<bool> isRememberLogin = false.obs;
  TextEditingController emailController = TextEditingController()..text = '';
  TextEditingController passwordController = TextEditingController()..text = '';

  // Login with Google
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final GoogleSignIn googleSignIn = GoogleSignIn(
  //   clientId: '1066112948220-tj8vifa8sk1soue81r73jlic6m77dqmu.apps.googleusercontent.com',
  //   scopes: [
  //     'email',
  //   ],
  // );

  @override
  Future<void> onInit() async {
    getUsernameAndPasswordFromLocal();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> getUsernameAndPasswordFromLocal() async {
    final userNamePassword = await storage.getUsernamePasswordFromLocal();
    if (userNamePassword == null) return;
    emailController.text = userNamePassword['username'];
    passwordController.text = userNamePassword['password'];
    isRememberLogin.value = true;
  }

  Future<void> loginWithEmail() async {
    try {
      pageLoadingOn();

      LoginRequest data = LoginRequest(username: emailController.text, password: passwordController.text);
      await userRepository.login(data);

      if (isRememberLogin.value) {
        await storage.saveUsernameAndPasswordToLocal(username: emailController.text, password: passwordController.text);
      } else {
        await storage.removeUsernameAndPasswordFromLocal();
      }
      Get.offNamed(Routes.home);
    } catch (e, s) {
      HandleExceptionHelper.rest(e, s);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        pageLoadingOff();
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String idToken = googleAuth.idToken ?? '';
      final String clientId = GetPlatform.isAndroid
          ? '1066112948220-tj8vifa8sk1soue81r73jlic6m77dqmu.apps.googleusercontent.com'
          : '1066112948220-g645ocsnhdqdbcfn8s366cumi9qovgsf.apps.googleusercontent.com';
      final url = Uri.parse('https://account.olm.vn/social/google/hoc24-callback');
      final Map<String, String> data = {
        'credential': idToken,
        'client_id': clientId,
      };

      // Gửi request xác thực tới API backend
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        LoginRequest data = LoginRequest(
          accessToken: responseBody['access_token'],
          refreshToken: responseBody['refresh_token'],
        );
        await userRepository.login(data);
        Get.offNamed(Routes.home);
      }
    } catch (e, s) {
      HandleExceptionHelper.rest(e, s);
    }
  }

  Future<void> sendMailForgetPassword() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        email: emailController.text,
      );
      Get.back();
      bool result = await graphQLService.sendMailForgetPassword(getDataRequest: data);

      if (result) {
        SnackBarHelper.successSnackBar('Hãy kiểm tra email để đặt lại mật khẩu');
      }
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }
}
