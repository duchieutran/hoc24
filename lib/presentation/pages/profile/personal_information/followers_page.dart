import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/followers/followers_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/pages/profile/card/follower_card.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final FollowersController controller = Get.find(tag: Get.arguments['id']);
    return Obx(
      () => BaseScaffold(
        appBar: AppBar(
          title: Text(controller.name),
        ),
        isPaddingDefault: false,
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                dividerColor: AppColors.lightGrey,
                dividerHeight: 0.5,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: theme.colorScheme.primary,
                tabAlignment: TabAlignment.center,
                labelColor: theme.colorScheme.onSurface,
                unselectedLabelColor: AppColors.lightGrey,
                controller: controller.tabController,
                tabs: [
                  AutoSizeText(
                    'Người theo dõi',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                  AutoSizeText(
                    'Đang theo dõi',
                    textAlign: TextAlign.center,
                    style: text18.bold.height22Per,
                    minFontSize: 12,
                  ),
                ],
              ),
              // const Divider(color: AppColors.lightGrey, height: 1),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildFollowerList(controller, theme),
                    buildFollowingList(controller, theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomScrollView buildFollowerList(FollowersController controller, ThemeData theme) {
    return CustomScrollView(
      controller: controller.scrollControllerFollower,
      slivers: [
        controller.pageLoading && controller.followerList.isEmpty
            ? SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 20)),
              )
            : controller.followerList.isEmpty
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                    sliver: SliverToBoxAdapter(
                      child: Center(child: Text('Không tìm thấy người dùng nào', style: theme.textTheme.bodyLarge)),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Obx(() {
                            UserEntity? user = controller.followerList[index].userFollower;
                            return FollowerCard(
                              user: user,
                              onFollow: () => controller.onFollow(index),
                              onTap: () => controller.goToPersonalInformationPage(user?.id ?? ''),
                            );
                          });
                        },
                        childCount: controller.followerList.length,
                      ),
                    ),
                  ),
        if (controller.pageLoading && controller.hasNextPageFollower.value)
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 32),
            sliver: SliverToBoxAdapter(child: CupertinoActivityIndicator()),
          )
      ],
    );
  }

  CustomScrollView buildFollowingList(FollowersController controller, ThemeData theme) {
    return CustomScrollView(
      controller: controller.scrollControllerFollowing,
      slivers: [
        controller.pageLoading && controller.followingList.isEmpty
            ? SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 10)),
              )
            : controller.followingList.isEmpty
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                    sliver: SliverToBoxAdapter(
                      child: Center(child: Text('Không tìm thấy người dùng nào', style: theme.textTheme.bodyLarge)),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Obx(() {
                            UserEntity? user = controller.followingList[index].userFollowing;
                            return FollowerCard(
                              user: user,
                              onFollow: () => controller.onFollow(index),
                              onTap: () => controller.goToPersonalInformationPage(user?.id ?? ''),
                            );
                          });
                        },
                        childCount: controller.followingList.length,
                      ),
                    ),
                  ),
        if (controller.pageLoading && controller.hasNextPageFollowing.value)
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 32),
            sliver: SliverToBoxAdapter(child: CupertinoActivityIndicator()),
          )
      ],
    );
  }
}
