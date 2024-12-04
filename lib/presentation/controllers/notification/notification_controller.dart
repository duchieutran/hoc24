import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/fetch/update_notification_request.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/app_bar/notification_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends BaseController {
  RxList<NotificationNode> notificationList = <NotificationNode>[].obs;
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
      getNotification(),
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
      getNotification();
    }
  }

  Future<void> getNotification() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(),
        pagination: Pagination(sorted: 'id', direction: 'desc'),
        after: endCursor.value,
        accessToken: appController.accessToken ?? '',
      );
      NotificationEntity notificationEntity = await graphQLService.getNotification(getDataRequest: data);
      if (notificationEntity.edges != null) {
        notificationList.value += notificationEntity.edges!
            .map((edge) => edge.node)
            .where((node) => node != null)
            .cast<NotificationNode>()
            .toList();
      } else {
        notificationList.value = [];
      }
      hasNextPage.value = notificationEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = notificationEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> updateNotification(int? id) async {
    try {
      UpdateNotificationRequest data = UpdateNotificationRequest(
        formUpdateNotification: FormUpdateNotification(
          ids: id != null ? [id] : null,
          status: 'READED',
        ),
        accessToken: appController.accessToken ?? '',
      );
      await graphQLService.updateNotification(request: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  void onTap(int? id, int index) {
    updateNotification(id);
    notificationList[index] = notificationList[index].copyWith(viewed: 1);
  }

  void goToPersonalInformationPage(String id) {
    Get.toNamed('${Routes.personalInformation}?id=$id');
  }

  String getTimeAgo(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Tính toán sự khác biệt về thời gian
    Duration difference = dateNow.difference(date);

    String displayTime;
    if (difference.inDays > 365) {
      // Nếu hơn 1 năm trước, hiển thị ngày cụ thể
      displayTime = DateFormat('dd \'tháng\' MM, yyyy \'lúc\' HH:mm').format(date);
    } else {
      // Nếu không, hiển thị thời gian tương đối
      displayTime = timeago.format(date, locale: 'vi');
    }

    return displayTime;
  }
}
