import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/fetch/update_message_request.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/app_bar/conversation_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationController extends BaseController {
  RxList<ConversationNode> conversationList = <ConversationNode>[].obs;
  RxBool hasNextPage = false.obs;
  RxString endCursor = ''.obs;
  final ScrollController scrollController = ScrollController();
  DateTime dateNow = DateTime.now();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    scrollController.addListener(scrollListener);
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    await Future.wait([
      getConversation(),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        hasNextPage.value) {
      getConversation();
    }
  }

  Future<void> getConversation({bool isClear = false}) async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(),
        pagination: Pagination(sorted: 'id', direction: 'desc'),
        after: endCursor.value,
        accessToken: appController.accessToken ?? '',
      );
      ConversationEntity conversationEntity = await graphQLService.getConversation(getDataRequest: data);
      if (isClear) conversationList.clear();
      if (conversationEntity.edges != null) {
        conversationList.value += conversationEntity.edges!
            .map((edge) => edge.node)
            .where((node) => node != null)
            .cast<ConversationNode>()
            .toList();
      } else {
        conversationList.value = [];
      }
      hasNextPage.value = conversationEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = conversationEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> updateMessage(String? receive) async {
    try {
      UpdateMessageRequest data = UpdateMessageRequest(
        formUpdateMessage: FormUpdateMessage(
          send: receive,
          readed: 1,
        ),
        accessToken: appController.accessToken ?? '',
      );
      await graphQLService.updateMessage(request: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  UserEntity getUser(ConversationNode conversation) {
    if (conversation.infoFromUser?.id == appController.user?.id) {
      return conversation.infoToUser ?? UserEntity();
    } else {
      return conversation.infoFromUser ?? UserEntity();
    }
  }

  String getTimeAgo(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Tính toán sự khác biệt về thời gian
    Duration difference = dateNow.difference(date);

    String displayTime;
    if (difference.inDays < 7) {
      // Nếu ít hơn 7 ngày hiển thị thời gian tương đối
      displayTime = timeago.format(date, locale: 'vi');
    } else if (date.year == dateNow.year) {
      // Nếu trong năm nay
      displayTime = DateFormat('d \'thg\' M').format(date);
    } else {
      displayTime = DateFormat('d \'thg\' M, yyyy').format(date);
    }

    return displayTime;
  }

  void goToChatPage(String name, String receive, String images) {
    Get.toNamed(
      Routes.chat,
      arguments: {
        'title': name,
        'receive': receive,
        'images': images,
      },
    )?.then((_) {
      hasNextPage.value = false;
      endCursor.value = '';
      getConversation(isClear: true);
    });

    updateMessage(receive);
  }

  void goToPersonalInformationPage(String id) {
    Get.toNamed('${Routes.personalInformation}?id=$id');
  }
}
