import 'package:get/get.dart';
import 'user_boards_controller.dart';

class UserBoardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserBoardsController());
  }
}
