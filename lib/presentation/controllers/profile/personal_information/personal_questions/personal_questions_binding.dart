import 'package:get/get.dart';

import 'personal_questions_controller.dart';

class PersonalQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonalQuestionsController(), tag: Get.arguments['id']);
  }
}
