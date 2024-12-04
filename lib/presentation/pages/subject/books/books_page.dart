import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/subject/books/books_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

import 'card/books_card.dart';

class BooksPage extends GetView<BooksController> {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => BaseScaffold(
        backgroundColor:
            controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          title: Text('${controller.nameSubject} lớp ${controller.appController.grade}'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chọn bộ sách', style: theme.textTheme.titleLarge?.copyWith(fontSize: 22)),
              const SizedBox(height: 16),
              Expanded(child: _buildBooksList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBooksList() {
    return controller.pageLoading
        ? AppLoading(count: 4, height: Get.height / 5 - 30)
        : ListView.separated(
            itemCount: controller.booksList.length,
            itemBuilder: (BuildContext context, int index) {
              return BooksCard(
                booksEntity: controller.booksList[index],
                nameSubject: controller.nameSubject,
                idSubject: controller.idSubject,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 16,
            ),
          );
  }
}
