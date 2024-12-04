import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/domain/models/response/app_bar/chat_entity.dart';
import 'package:hoc24/presentation/controllers/message/chat_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/pages/message/chat/card/chat_card.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BaseScaffold(
          isPaddingDefault: false,
          appBar: AppBar(
            title:
                GestureDetector(onTap: () => controller.goToPersonalInformationPage(), child: Text(controller.title)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Expanded(
                  child: _buildChatList(theme),
                ),
                const SizedBox(height: 16),
                _buildTextComposer(context, theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(ThemeData theme) {
    return controller.pageLoading && controller.chatList.isEmpty
        ? AppLoading(count: 4, height: Get.height / 5 - 25)
        : controller.chatList.isEmpty
            ? Center(child: Text('Hãy bắt đầu cuộc trò chuyện', style: theme.textTheme.titleLarge))
            : ListView.separated(
                controller: controller.scrollController,
                reverse: true,
                padding: EdgeInsets.zero,
                itemCount: controller.chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () {
                      ChatNode chat = controller.chatList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (controller.pageLoading &&
                              controller.hasNextPage.value &&
                              index == controller.chatList.length - 1)
                            const Center(child: CupertinoActivityIndicator()),
                          ChatCard(
                            name: controller.getName(chat.send ?? ''),
                            images: controller.images,
                            isUser: chat.send == controller.appController.user?.id,
                            text: chat.content ?? '',
                            timeAgo: controller.getTimeAgo(chat.created ?? 0),
                            isShowTimeAgo: controller.selectedMessage.value == index,
                            index: index,
                            onTapMessage: (_) => controller.onTapMessage(index),
                          ),
                        ],
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
              );
  }

  Widget _buildTextComposer(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: controller.appController.isDarkMode.value ? AppColors.darkSecondary : AppColors.nature20,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              style: theme.textTheme.bodyLarge,
              controller: controller.textEditingController,
              decoration: const InputDecoration(
                isCollapsed: true,
                hintText: "Aa",
                contentPadding: EdgeInsets.zero,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              maxLines: 3,
              minLines: 1,
              autofocus: false,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: AppColors.lightPrimary),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (controller.textEditingController.text != "") {
              controller.handleSubmitted(controller.textEditingController.text);
            }
          },
        ),
      ],
    );
  }
}
