import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_icon.dart';
import 'package:hoc24/presentation/widgets/app_tag.dart';

import 'widget/loading_widget.dart';

class BaseScaffold extends GetView<AppController> {
  final Widget body;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? backgroundChild;
  final bool isPaddingDefault;
  final bool isLandscape;
  final EdgeInsetsGeometry? marginCustom;
  final EdgeInsetsGeometry? paddingCustom;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final bool isLoading;
  final bool isShowAppBarCustom;
  final String? currentRoute;
  final VoidCallback? onTapChanged;

  const BaseScaffold({
    super.key,
    required this.body,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.backgroundChild,
    this.paddingCustom,
    this.marginCustom,
    this.isPaddingDefault = true,
    this.isLandscape = false,
    this.resizeToAvoidBottomInset = true,
    this.isLoading = false,
    this.isShowAppBarCustom = false,
    this.appBar,
    this.currentRoute,
    this.onTapChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: isPaddingDefault
              ? Container(
                  margin: marginCustom,
                  padding: paddingCustom ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: body,
                )
              : body,
          bottomSheet: bottomSheet,
          bottomNavigationBar: bottomNavigationBar,
          appBar: isShowAppBarCustom
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: appBarCustom(context, theme),
                )
              : appBar,
          floatingActionButton: floatingActionButton,
        ),
        if (isLoading)
          const Center(
            child: LoadingWidget(),
          ),
      ],
    );
  }

  Widget appBarCustom(BuildContext context, ThemeData theme) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
        decoration: BoxDecoration(
          color: controller.isDarkMode.value ? AppColors.darkSecondary : AppColors.lightBlue20,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0),
          ),
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTapChanged,
                child: AppAvatar(
                  name: controller.user?.name ?? '',
                  url: controller.user?.images ?? '',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user?.name ?? 'Name',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => showBottomSheet(context, theme),
                    child: Obx(() => AppTag(
                          label: getGradeTitle,
                          isShowIcon: true,
                          color: AppColors.lightBlue40,
                        )),
                  ),
                ],
              ),
              const Spacer(),
              // AppIcon(icon: Icons.search, color: theme.colorScheme.onSurface),
              // const SizedBox(width: 16),
              GestureDetector(
                onTap: () => controller.goToNotificationPage(),
                child: AppIcon(
                    icon: Icons.notifications_outlined,
                    countBadges: controller.countNotification.value,
                    color: theme.colorScheme.onSurface),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => controller.goToMessagePage(),
                child: AppIcon(
                    icon: CupertinoIcons.chat_bubble_2,
                    countBadges: controller.countMessage.value,
                    color: theme.colorScheme.onSurface),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  String get getGradeTitle => controller.grade.value != -1 ? 'Lớp ${controller.grade.value}' : 'Chọn lớp';

  void showBottomSheet(BuildContext context, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (BuildContext context) {
        return Container(
          height: Get.width * 0.7 + 120,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close, color: Colors.transparent),
                    Center(
                      child: Text(
                        'Chọn lớp',
                        style: theme.textTheme.titleMedium?.copyWith(fontSize: 20),
                      ),
                    ),
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.close, size: 30))
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                  ),
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    final grade = index + 1;
                    return Obx(() => GestureDetector(
                          onTap: () {
                            controller.selectedGrade.value = index + 1;
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: controller.selectedGrade.value == (index + 1)
                                    ? theme.colorScheme.primary
                                    : AppColors.nature20,
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text('Lớp $grade', style: theme.textTheme.bodyMedium),
                          ),
                        ));
                  },
                ),
              ),
              AppButton(
                  text: 'Xác nhận',
                  onPressed: () {
                    controller.onSubmitGrade();
                  })
            ],
          ),
        );
      },
    );
  }
}
