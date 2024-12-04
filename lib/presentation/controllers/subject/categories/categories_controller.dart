import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/helpers/snack_bar_helper.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/categories_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class CategoriesController extends BaseController {
  String nameSubject = '';
  String nameBook = '';
  int idSubject = 0;
  int idBook = 0;
  RxList<CategoriesEntity> categoriesList = <CategoriesEntity>[].obs;
  RxInt selectedIndex = (-1).obs;
  final ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    final args = Get.arguments as Map<String, dynamic>;
    nameSubject = args['nameSubject'] ?? '';
    idSubject = args['idSubject'] ?? 0;
    nameBook = args['nameBook'] ?? '';
    idBook = args['idBook'] ?? 0;

    await getCategories();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> getCategories() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(
          idGrade: appController.grade.value,
          idSubject: idSubject,
          idBook: idBook,
          idParent: 0,
        ),
      );
      categoriesList.value = await graphQLService.getCategories(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  void onTap(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
      if (categoriesList[index].children != null && categoriesList[index].children!.isNotEmpty) {
        scrollController.animateTo(
          (92 * index).toDouble(),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        SnackBarHelper.warningSnackBar('Nội dung đang được biên soạn');
      }
    }
  }
}
