import 'package:get/get.dart';
import 'articles_controller.dart';

class ArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticlesController());
  }
}
