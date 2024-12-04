import 'package:get/get.dart';

import 'examination_detail_controller.dart';

class ExaminationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExaminationDetailController());
  }
}
