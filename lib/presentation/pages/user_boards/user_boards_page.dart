import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/types/sort_type.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/user_boards_entity.dart';
import 'package:hoc24/presentation/controllers/user_boards/user_boards_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'card/user_boards_card.dart';

class UserBoardsPage extends GetView<UserBoardsController> {
  const UserBoardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BaseScaffold(
          isPaddingDefault: false,
          isLoading: controller.pageLoading,
          body: SlidingUpPanel(
            controller: controller.panelController,
            backdropEnabled: true,
            header: header(),
            color: theme.colorScheme.surface,
            maxHeight: Get.height * 0.9,
            minHeight: Get.height * 0.65,
            borderRadius: BorderRadius.circular(30),
            body: body(),
            panelBuilder: (ScrollController scrollController) => _buildList(scrollController, theme),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return GestureDetector(
      onPanStart: (details) {
        if (details.globalPosition.dy > 0) {
          controller.panelController.animatePanelToPosition(0.0); // close panel
        } else {
          controller.panelController.animatePanelToPosition(1.0); // open panel
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: 6,
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: Get.width / 2 - 25, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightBlue30),
        ),
      ),
    );
  }

  Widget body() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          'assets/data/leader-board.png',
          width: Get.width,
        ),
        Positioned(
          top: 6,
          left: 10,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: GetPlatform.isAndroid
                  ? const Icon(Icons.arrow_back, color: AppColors.dark)
                  : const Icon(Icons.arrow_back_ios_sharp, color: AppColors.dark),
            ),
          ),
        ),
        Positioned(top: 6, child: SafeArea(child: Text("Bảng xếp hạng", style: text20.bold.textDarkColor))),

        // Rank 1st
        if (!controller.pageLoading)
          Positioned(
            top: Get.height * 0.04,
            child: SafeArea(child: _buildRank(controller.userBoardList[0], 25)),
          ),
        // Rank 2nd
        if (!controller.pageLoading)
          Positioned(
            top: Get.height * 0.09,
            right: Get.width * 0.64,
            child: SafeArea(child: _buildRank(controller.userBoardList[1], 22)),
          ),
        // Rank 3rd
        if (!controller.pageLoading)
          Positioned(
            top: Get.height * 0.12,
            left: Get.width * 0.64,
            child: SafeArea(child: _buildRank(controller.userBoardList[2], 20)),
          )
      ],
    );
  }

  Widget _buildRank(UserBoardNode userBoardNode, double radius) {
    int point = 0;

    switch (controller.selectedSortType.value) {
      case SortType.sweek:
        point = userBoardNode.sweek ?? 0;
      case SortType.smonth:
        point = userBoardNode.smonth ?? 0;
      case SortType.summAll:
        point = userBoardNode.sumAll ?? 0;
      default:
        point = 0;
    }
    return Transform.scale(
      scale: Get.width / 430,
      child: GestureDetector(
        onTap: () => controller.goToPersonalInformationPage(userBoardNode.userEntity?.id ?? ''),
        child: Column(
          children: [
            AppAvatar(
              name: userBoardNode.userEntity?.name ?? '',
              radius: radius,
              url: userBoardNode.userEntity?.images ?? '',
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: Get.width * 0.3,
              child: Text(
                userBoardNode.userEntity?.name ?? '',
                style: text13.bold.textDarkColor,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 80,
              height: 16,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Center(
                    child: Text(point.toString(), style: text12.bold.textLightColor),
                  ),
                ],
              ),
            ),
          ],
        ).animate(delay: 0.ms).fadeIn(delay: 0.ms).slideY(begin: 0.3, end: 0),
      ),
    );
  }

  Padding _buildFilter(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          DropdownMenu<SubjectEntity>(
            initialSelection: controller.selectedSubject.value,
            controller: controller.subjectController,
            requestFocusOnTap: true,
            // enableFilter: true,
            label: Text('Môn học', style: theme.textTheme.bodyMedium),
            textStyle: theme.textTheme.bodyMedium,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.colorScheme.onSurface),
              ),
            ),
            menuHeight: 250,
            width: Get.width * 0.6 - 24,
            onSelected: (SubjectEntity? subject) async {
              controller.idSubject.value = subject?.id ?? 0;
              await controller.refreshData();
            },
            dropdownMenuEntries: controller.subjectList.map((SubjectEntity subject) {
              return DropdownMenuEntry<SubjectEntity>(
                value: subject,
                label: subject.name ?? 'Môn học',
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
          DropdownMenu<SortType>(
            initialSelection: controller.selectedSortType.value,
            controller: controller.sortTypeController,
            label: Text(
              'Sắp xếp theo',
              style: theme.textTheme.bodyMedium,
            ),
            textStyle: theme.textTheme.bodyMedium,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            width: Get.width * 0.4 - 25,
            onSelected: (SortType? type) async {
              controller.selectedSortType.value = type ?? SortType.sweek;
              await controller.refreshData();
            },
            dropdownMenuEntries: controller.softTypeList.map((SortType item) {
              return DropdownMenuEntry<SortType>(
                value: item,
                label: item.name,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList(ScrollController scrollController, ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 30),
        _buildFilter(theme),
        const SizedBox(height: 5),
        const Divider(
          color: AppColors.lightGrey,
        ),
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              controller.pageLoading && controller.userBoardList.isEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 10)),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.zero,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            UserBoardNode userBoard = controller.userBoardList[index + 3];
                            return UserBoardsCard(
                              userBoard: userBoard,
                              sortType: controller.selectedSortType.value,
                              index: index + 3,
                              onTap: () => controller.goToPersonalInformationPage(userBoard.userEntity?.id ?? ''),
                            );
                          },
                          childCount: controller.userBoardList.length - 3,
                        ),
                      ),
                    ),
              if (controller.hasNextPage.value)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  sliver: SliverToBoxAdapter(
                    child: AppButton(
                      text: 'Xem thêm',
                      onPressed: () => controller.getUserBoards(),
                      isLoading: controller.pageLoading,
                      backgroundColor:
                          controller.appController.isDarkMode.value ? AppColors.darkSecondary : AppColors.lightBlue30,
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
