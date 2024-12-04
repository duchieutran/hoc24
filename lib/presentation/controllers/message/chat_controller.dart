import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/fetch/send_message_request.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/app_bar/chat_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatController extends BaseController {
  RxList<ChatNode> chatList = <ChatNode>[].obs;
  RxBool hasNextPage = false.obs;
  RxString endCursor = ''.obs;
  final ScrollController scrollController = ScrollController();
  DateTime dateNow = DateTime.now();
  String title = '';
  String receive = '';
  String images = '';

  final TextEditingController textEditingController = TextEditingController();
  RxInt selectedMessage = 0.obs;

  @override
  Future<void> onInit() async {
    final args = Get.arguments as Map<String, dynamic>;
    title = args['title'] ?? '';
    receive = args['receive'] ?? '';
    images = args['images'] ?? '';

    scrollController.addListener(scrollListener);
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    await Future.wait([
      getChat(),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> getChat() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(receive: receive),
        pagination: Pagination(sorted: 'id', direction: 'desc'),
        after: endCursor.value,
        accessToken: appController.accessToken ?? '',
      );
      ChatEntity chatEntity = await graphQLService.getChat(getDataRequest: data);
      if (chatEntity.edges != null) {
        chatList.value +=
            chatEntity.edges!.map((edge) => edge.node).where((node) => node != null).cast<ChatNode>().toList();
      } else {
        chatList.value = [];
      }
      hasNextPage.value = chatEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = chatEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> sendMessage(String text) async {
    try {
      SendMessageRequest data = SendMessageRequest(
        formCreateMessage: FormCreateMessage(content: text, receive: receive),
        accessToken: appController.accessToken ?? '',
      );
      await graphQLService.sendMessage(sendMessageRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        hasNextPage.value) {
      getChat();
    }
  }

  String getName(String id) {
    if (id == appController.user?.id) {
      return appController.user?.name ?? '';
    } else {
      return title;
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
      displayTime = DateFormat('d \'thg\' M \'lúc\' H:m').format(date);
    } else {
      displayTime = DateFormat('d \'thg\' M, yyyy \'lúc\' H:m').format(date);
    }

    return displayTime;
  }

  void onTapMessage(int index) {
    if (index != selectedMessage.value) {
      selectedMessage.value = index;
    } else {
      selectedMessage.value = -1;
    }
  }

  void goToPersonalInformationPage() {
    Get.toNamed('${Routes.personalInformation}?id=$receive');
  }

  Future<void> handleSubmitted(String text) async {
    chatList.insert(
      0,
      ChatNode(
        send: appController.user?.id,
        content: textEditingController.text,
        created: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
    sendMessage(text);
    selectedMessage.value = -1;
    textEditingController.clear();
  }
}
