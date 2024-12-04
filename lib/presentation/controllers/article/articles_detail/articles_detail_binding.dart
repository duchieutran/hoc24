import 'package:get/get.dart';

import 'articles_detail_controller.dart';

class ArticlesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticlesDetailController());
  }
}
