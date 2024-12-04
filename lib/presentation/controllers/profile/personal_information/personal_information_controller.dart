import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class PersonalInformationController extends BaseController {
  String id = '';
  Rx<UserEntity> user = UserEntity().obs;

  @override
  Future<void> onInit() async {
    id = Get.parameters['id'] ?? '';

    pageLoadingOn();
    user.value = await appController.getUser(id) ?? UserEntity();
    pageLoadingOff();
    super.onInit();
  }

  Future<void> followUser(String id) async {
    try {
      GetDataRequest data = GetDataRequest(
        iduser: id,
        accessToken: appController.accessToken ?? '',
      );
      await graphQLService.followUser(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  void onFollow(String id) {
    followUser(id);
    user.value = user.value.copyWith(
      userInfo: user.value.userInfo?.copyWith(
        isFollow: !(user.value.userInfo?.isFollow ?? false),
      ),
    );
  }

  void goToPersonalQuestionPage() {
    Get.toNamed(Routes.personalQA, arguments: {
      'id': id,
    });
  }

  void goToFollowersPage(int index) {
    Get.toNamed(
      Routes.followers,
      arguments: {
        'id': id,
        'name': user.value.name,
        'index': index,
      },
    );
  }

  void goToPersonalInformationPage() {
    Get.toNamed(Routes.editPersonalInformation);
  }

  void goToChatPage(String name, String receive) {
    Get.toNamed(
      Routes.chat,
      arguments: {
        'title': name,
        'receive': receive,
      },
    );
  }

  String getAddress(String input) {
    if (input.isEmpty) return '';

    input = input.replaceFirst('Tỉnh thành: ', '');
    input = input.replaceFirst('Quận huyện: ', '');
    input = input.replaceAll('Chưa có thông tin', '');

    if (input.startsWith(' / ') || input.endsWith(' / ')) {
      input = input.replaceAll(' / ', '');
    }

    return input.trim();
  }

  UserInfo? get userInfo => user.value.userInfo;

  bool get isMe => user.value.id == appController.user?.id;
}
