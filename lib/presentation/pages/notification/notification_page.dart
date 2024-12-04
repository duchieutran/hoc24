import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/notification/notification_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

import 'card/notification_card.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => BaseScaffold(
        appBar: AppBar(
          title: const Text('Thông báo'),
        ),
        isPaddingDefault: false,
        body: SafeArea(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              controller.pageLoading && controller.notificationList.isEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 10)),
                    )
                  : controller.notificationList.isEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                          sliver: SliverToBoxAdapter(
                              child: Center(child: Text('Chưa có thông báo nào', style: theme.textTheme.titleLarge))),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Obx(() => NotificationCard(
                                      notification: controller.notificationList[index],
                                      timeAgo: controller.getTimeAgo(controller.notificationList[index].created ?? 0),
                                      onTap: () => controller.onTap(controller.notificationList[index].id, index),
                                      onTapAvatar: () => controller.goToPersonalInformationPage(
                                          controller.notificationList[index].infoFromUser?.id ?? ''),
                                    ));
                              },
                              childCount: controller.notificationList.length,
                            ),
                          ),
                        ),
              if (controller.pageLoading && controller.hasNextPage.value)
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 32),
                  sliver: SliverToBoxAdapter(child: CupertinoActivityIndicator()),
                )
            ],
          ),
        ),
      ),
    );
  }
}
