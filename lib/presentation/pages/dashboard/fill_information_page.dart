import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';
import 'package:hoc24/presentation/widgets/app_button.dart';
import 'package:hoc24/presentation/widgets/app_text_field.dart';

class FillInformationPage extends GetView<AppController> {
  const FillInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    TextEditingController gradeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BaseScaffold(
      backgroundColor: Get.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildForm(context, gradeController, formKey, theme),
            const SizedBox(height: 16),
            AppButton(
              text: 'Tiếp tục',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onSubmitInformation();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm(
      BuildContext context, TextEditingController gradeController, GlobalKey<FormState> formKey, ThemeData theme) {
    return Form(
      key: formKey,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text('THÔNG TIN CÁ NHÂN', style: theme.textTheme.titleLarge?.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              Text('Hãy cho HOC24 biết về bạn nhé', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 48),
              AppTextField(
                title: 'Lớp',
                hintText: 'Chọn lớp',
                controller: gradeController,
                readOnly: true,
                onTap: () => showBottomSheet(context, gradeController, theme),
                icon: Icons.keyboard_arrow_down_outlined,
                iconColor: theme.colorScheme.onSurface,
                obscureText: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Vui lòng chọn lớp';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, TextEditingController gradeController, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (BuildContext context) {
        return Container(
          height: 450,
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
                      child: Text('Chọn lớp', style: theme.textTheme.titleMedium?.copyWith(fontSize: 20)),
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
                    gradeController.text = 'Lớp ${controller.selectedGrade.value}';
                    Get.back();
                  })
            ],
          ),
        );
      },
    );
  }
}
