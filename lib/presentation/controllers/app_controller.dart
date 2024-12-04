import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/app/logger/flutter_logger.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/app/storage/app_storage.dart';
import 'package:hoc24/app/util/dependency.dart';
import 'package:hoc24/data/providers/network/apis/api_constants.dart';
import 'package:hoc24/data/providers/network/apis/rest_client.dart';
import 'package:hoc24/data/providers/network/apis/services/user_service.dart';
import 'package:hoc24/data/providers/network/graphql/services/graphql_service.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/request/user/get_user_request.dart';
import 'package:hoc24/domain/models/request/user/logout_request.dart';
import 'package:hoc24/domain/models/request/user/update_user_request.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/controllers/dashboard/dashboard_controller.dart';

class AppController extends GetxController {
  late final AppStorage storage;
  final GraphQLService graphQLService =
      GraphQLService(); // TODO : ??? Này là cái gì (1)

  bool isLoggedIn = false;
  final isNextPage = false.obs;
  String? accessToken;
  RxString selectedDarkMode = 'System'.obs;
  RxBool isDarkMode = false.obs;

  final Rx<UserEntity?> _user = Rx<UserEntity?>(null);
  UserEntity? get user => _user.value;
  set user(value) => _user.value = value;

  RxInt selectedGrade = (-1).obs;
  RxInt grade = (-1).obs;

  RxInt countNotification = 0.obs;
  RxInt countMessage = 0.obs;

  init() async {
    await initStorage();
    storage = Get.find<AppStorage>();
    initDarkMode();
    await setupLocator();
    await initAuth();
  }

  @override
  void onClose() {
    // Close all service
    Get.reset();
    super.onClose();
  }

  Future<void> initAuth() async {
    user = await storage.getUserInfo();
    accessToken = await storage.getToken();
    await initApi(accessToken);
    if (accessToken != null && accessToken!.isNotEmpty) {
      try {
        UserEntity? userEntity = await getUser(user?.id ?? '');
        if (userEntity != null) {
          updateUserInfo(userEntity);
          isLoggedIn = true;
        }
      } catch (e) {
        Logger.e('Response Exception: $e');
      }
    }
    if (!isLoggedIn && accessToken != null && accessToken!.isNotEmpty) {
      await onLogout(isGoToLoginPage: false);
      SnackBarHelper.errorSnackBar('Phiên đăng nhập của bạn đã hết hạn');
    }
  }

  Future<void> initStorage() async {
    await Get.put(AppStorage()).init();
  }

  Future<void> initDarkMode() async {
    selectedDarkMode.value = await storage.getDarkMode() ?? 'System';
    setDarkMode(selectedDarkMode.value);
  }

  initApi(String? accessToken) async {
    RestClient.instance.init(BASE_URL_AUTH, accessToken: accessToken ?? '');
  }

  void setDarkMode(String option, {BuildContext? context}) {
    selectedDarkMode.value = option;
    if (option == 'Off') {
      isDarkMode.value = false;
    } else if (option == 'On') {
      isDarkMode.value = true;
    } else if (context != null) {
      isDarkMode.value =
          MediaQuery.of(Get.context!).platformBrightness == Brightness.dark;
    } else {
      isDarkMode.value = Get.isDarkMode;
    }

    if (isDarkMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  Future<void> getCountNotification() async {
    try {
      GetDataRequest data = GetDataRequest(
        filter: Filter(viewed: 0),
        accessToken: accessToken ?? '',
      );
      countNotification.value =
          await graphQLService.getCountNotification(getDataRequest: data);
    } catch (error) {
      // HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> getCountMessage() async {
    try {
      GetDataRequest data = GetDataRequest(
        filter: Filter(receive: '123', readed: 0),
        accessToken: accessToken ?? '',
      );
      countMessage.value =
          await graphQLService.getCountMessage(getDataRequest: data);
    } catch (error) {
      // HandleExceptionHelper.graphql(error);
    }
  }

  void updateUserInfo(UserEntity u) {
    user = u;
    storage.saveUserInfo(u);
    if (user?.grades != null && user!.grades!.isNotEmpty) {
      grade.value = user?.grades?[0] ?? -1;
      selectedGrade.value = grade.value;
    }
    getCountNotification();
    getCountMessage();
  }

  void updateAccessToken(String token) {
    accessToken = token;
  }

  Future<void> onLogout({bool isGoToLoginPage = true}) async {
    try {
      final userService = Get.find<UserService>();
      LogoutRequest request = LogoutRequest(accessToken: accessToken ?? '');
      await userService.logOut(request);
      await storage.logout();
      user = null;
      isLoggedIn = false;
      grade.value = -1;
      selectedGrade.value = -1;
      if (isGoToLoginPage) {
        Get.offAllNamed(Routes.login);
      }
    } catch (e, s) {
      HandleExceptionHelper.rest(e, s);
    }
  }

  Future<UserEntity?> getUser(String id) async {
    try {
      GetUserRequest data =
          GetUserRequest(idUser: id, accessToken: accessToken ?? '');
      return await graphQLService.getUser(getUserRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
    return null;
  }

  Future<void> updateUser() async {
    try {
      UpdateUserRequest data = UpdateUserRequest(
          formUpdateUser: FormUpdateUser(grades: [grade.value]),
          accessToken: accessToken ?? '');
      bool result = await graphQLService.updateUser(updateUserRequest: data);
      if (result) {
        SnackBarHelper.successSnackBar('Cập nhật thành công',
            duration: const Duration(seconds: 2));
      }
      Get.find<DashboardController>().getSubjects();
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> onSubmitGrade() async {
    grade.value = selectedGrade.value;
    Get.back();
    await updateUser();
  }

  Future<void> onSubmitInformation() async {
    grade.value = selectedGrade.value;
    await updateUser();
    Get.offNamed(Routes.home);
  }

  void goToNotificationPage() {
    Get.toNamed(
      Routes.notification,
    )?.then((_) {
      getCountNotification();
    });
  }

  void goToMessagePage() {
    Get.toNamed(
      Routes.conversation,
    )?.then((_) {
      getCountMessage();
    });
  }

  bool get isAndroid => GetPlatform.isAndroid;
}
