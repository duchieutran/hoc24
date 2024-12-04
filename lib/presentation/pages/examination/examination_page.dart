import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/domain/models/response/dashboard/examination_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/presentation/controllers/examination/examination_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/pages/examination/card/examination_card.dart';
import 'package:hoc24/presentation/widgets/app_loading.dart';

class ExaminationPage extends GetView<ExaminationController> {
  const ExaminationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BaseScaffold(
          backgroundColor:
              controller.appController.isDarkMode.value ? AppColors.darkBackground : AppColors.lightBackground,
          appBar: AppBar(title: const Text('Đề thi')),
          isPaddingDefault: true,
          body: Column(
            children: [
              _buildFilter(theme),
              const SizedBox(height: 8),
              _buildExamination(theme),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildFilter(ThemeData theme) {
    return Row(
      children: [
        DropdownMenu<int>(
          initialSelection: controller.selectedGrade.value,
          controller: controller.gradeController,
          label: Text(
            'Lớp',
            style: theme.textTheme.bodyMedium,
          ),
          textStyle: theme.textTheme.bodyMedium,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: theme.colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          menuHeight: 400,
          width: Get.width * 0.4 - 25,
          onSelected: (int? grade) async {
            controller.selectedGrade.value = grade ?? 0;
            controller.selectedSubject.value = SubjectEntity(name: 'Tất cả', id: 0);
            controller.subjectController.text = 'Tất cả';
            await controller.getSubjects();
            await controller.refreshData();
          },
          dropdownMenuEntries: controller.gradeList.map((int grade) {
            return DropdownMenuEntry<int>(
              value: grade,
              label: 'Lớp $grade',
            );
          }).toList(),
        ),
        const SizedBox(width: 16),
        DropdownMenu<SubjectEntity>(
          initialSelection: controller.selectedSubject.value,
          controller: controller.subjectController,
          requestFocusOnTap: true,
          // enableFilter: true,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.onSurface),
            ),
          ),
          menuHeight: 400,
          width: Get.width * 0.6 - 24,
          onSelected: (SubjectEntity? subject) async {
            controller.selectedSubject.value = subject!;
            await controller.refreshData();
          },
          dropdownMenuEntries: controller.subjectList.map((SubjectEntity subject) {
            return DropdownMenuEntry<SubjectEntity>(
              value: subject,
              label: subject.name ?? 'Môn học',
            );
          }).toList(),
        ),
      ],
    );
  }

  Expanded _buildExamination(ThemeData theme) {
    return Expanded(
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          controller.pageLoading && controller.examinationList.isEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  sliver: SliverToBoxAdapter(child: AppLoading(count: 4, height: Get.height / 5 - 25)),
                )
              : controller.examinationList.isEmpty
                  ? SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                      sliver: SliverToBoxAdapter(
                          child:
                              Center(child: Text('Nội dung đang được biên soạn', style: theme.textTheme.titleLarge))),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.only(bottom: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            ExaminationNode examination = controller.examinationList[index];
                            return ExaminationCard(
                              examination: examination,
                              onTap: () => controller.goToExaminationDetailPage(examination.id.toString()),
                            );
                          },
                          childCount: controller.examinationList.length,
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
    );
  }
}
