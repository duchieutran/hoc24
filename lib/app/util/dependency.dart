import 'package:get/get.dart';
import 'package:hoc24/data/providers/network/apis/services/user_service.dart';
import 'package:hoc24/domain/repositories/user_repository.dart';

Future<void> setupLocator() async {
  //Setup service
  Get.put(UserService());

  //Setup repository
  Get.put(UserRepository());
}
