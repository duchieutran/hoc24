import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/domain/models/response/app_bar/conversation_entity.dart';
import 'package:hoc24/presentation/controllers/message/conversation_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/pages/message/conversation/card/conversation_card.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

class ConversationPage extends GetView<ConversationController> {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => BaseScaffold(
        appBar: AppBar(
          title: const Text('Trò chuyện'),
        ),
        isPaddingDefault: false,
        body: SafeArea(
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              controller.pageLoading && controller.conversationList.isEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 10)),
                    )
                  : controller.conversationList.isEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                          sliver: SliverToBoxAdapter(
                              child: Center(
                                  child: Text('Chưa có cuộc trò chuyện nào', style: theme.textTheme.titleLarge))),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.zero,
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                ConversationNode conversation = controller.conversationList[index];
                                return ConversationCard(
                                  user: controller.getUser(conversation),
                                  isLastMessage: conversation.infoFromUser?.id == controller.appController.user?.id,
                                  isNewMessage: conversation.countmess != 0,
                                  lastmess: conversation.lastmess ?? '',
                                  timeAgo: controller.getTimeAgo(conversation.created ?? 0),
                                  onTap: controller.goToChatPage,
                                  onTapAvatar: controller.goToPersonalInformationPage,
                                );
                              },
                              childCount: controller.conversationList.length,
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
