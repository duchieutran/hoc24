import 'package:get/get.dart';
import 'article_categories_controller.dart';

class ArticleCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleCategoriesController());
  }
}
