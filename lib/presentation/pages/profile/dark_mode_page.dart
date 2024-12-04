import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';
import 'package:hoc24/presentation/pages/base/base_scaffold.dart';

class DarkModePage extends GetView<AppController> {
  const DarkModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseScaffold(
      isPaddingDefault: false,
      appBar: AppBar(
        title: const Text('Chế độ tối'),
      ),
      body: Column(
        children: [
          Obx(() => RadioListTile<String>(
                title: Text('Tắt', style: theme.textTheme.bodyLarge),
                value: 'Off',
                groupValue: controller.selectedDarkMode.value,
                onChanged: (value) {
                  controller.setDarkMode(value!);
                  controller.storage.saveDarkMode(value);
                },
              )),
          Obx(() => RadioListTile<String>(
                title: Text('Bật', style: theme.textTheme.bodyLarge),
                value: 'On',
                groupValue: controller.selectedDarkMode.value,
                onChanged: (value) {
                  controller.setDarkMode(value!);
                  controller.storage.saveDarkMode(value);
                },
              )),
          Obx(() => RadioListTile<String>(
                title: Text('Hệ thống', style: theme.textTheme.bodyLarge),
                value: 'System',
                groupValue: controller.selectedDarkMode.value,
                onChanged: (value) {
                  controller.setDarkMode(value!);
                  controller.storage.saveDarkMode(value);
                },
              )),
        ],
      ),
    );
  }
}
