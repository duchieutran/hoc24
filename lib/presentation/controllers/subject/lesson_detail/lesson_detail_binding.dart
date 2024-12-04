import 'package:get/get.dart';

import 'lesson_detail_controller.dart';

class LessonDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LessonDetailController());
  }
}
