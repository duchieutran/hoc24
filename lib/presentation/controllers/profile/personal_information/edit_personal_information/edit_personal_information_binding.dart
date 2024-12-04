import 'package:get/get.dart';

import 'edit_personal_information_controller.dart';

class EditPersonalInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditPersonalInformationController());
  }
}
