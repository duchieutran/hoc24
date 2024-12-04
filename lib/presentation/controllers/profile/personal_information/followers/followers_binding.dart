import 'package:get/get.dart';

import 'followers_controller.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FollowersController(), tag: Get.arguments['id']);
  }
}
