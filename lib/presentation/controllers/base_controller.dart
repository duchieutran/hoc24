import 'package:get/get.dart';
import 'package:hoc24/app/storage/app_storage.dart';
import 'package:hoc24/data/providers/network/apis/exceptions/data_exception.dart';
import 'package:hoc24/data/providers/network/graphql/services/graphql_service.dart';
import 'package:hoc24/presentation/controllers/app_controller.dart';

abstract class BaseController<C> extends GetxController {
  final storage = Get.find<AppStorage>();
  final appController = Get.find<AppController>();
  final GraphQLService graphQLService = GraphQLService();

  final isPageLoading = false.obs;
  DataException? dataException;

  void pageLoadingOn() => isPageLoading.value = true;
  void pageLoadingOff() => isPageLoading.value = false;

  bool get pageLoading => isPageLoading.value;
}
