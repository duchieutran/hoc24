import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/dashboard/dashboard_controller.dart';
import 'package:hoc24/presentation/controllers/profile/profile_controller.dart';
import 'package:hoc24/presentation/controllers/questions/questions_controller.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(DashboardController());
    Get.put(QuestionsController());
    Get.put(ProfileController());
  }
}
