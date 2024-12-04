import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/app/types/sort_type.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/user_boards_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserBoardsController extends BaseController {
  RxList<UserBoardNode> userBoardList = <UserBoardNode>[].obs;
  RxBool hasNextPage = false.obs;
  RxString endCursor = ''.obs;

  final PanelController panelController = PanelController();

  final TextEditingController subjectController = TextEditingController(text: 'Tất cả');
  final TextEditingController sortTypeController = TextEditingController();
  RxInt idSubject = 0.obs;
  Rx<SubjectEntity> selectedSubject = SubjectEntity().obs;
  Rx<SortType> selectedSortType = (SortType.sweek).obs;
  List<SubjectEntity> subjectList = [];
  List<SortType> softTypeList = [SortType.sweek, SortType.smonth, SortType.summAll];

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await Future.wait([
      getSubjects(),
      getUserBoards(),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    subjectController.dispose();
    sortTypeController.dispose();
    super.onClose();
  }

  Future<void> getSubjects() async {
    try {
      GetDataRequest data = GetDataRequest(typeBook: 'NEW');
      subjectList += await graphQLService.getSubjects(getDataRequest: data);
      SubjectEntity subjectEntity = SubjectEntity(name: 'Tất cả', id: 0);
      subjectList.insert(0, subjectEntity);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> getUserBoards() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
          filter: Filter(idSubject: idSubject.value, typed: 'DISCUSS'),
          pagination: Pagination(sorted: selectedSortType.value.query, direction: 'desc'),
          after: endCursor.value);
      UserBoardsEntity userBoardsEntity = await graphQLService.getUserBoards(getDataRequest: data);
      if (userBoardsEntity.edges != null) {
        userBoardList.value += userBoardsEntity.edges!
            .map((edge) => edge.node)
            .where((node) => node != null)
            .cast<UserBoardNode>()
            .toList();
      } else {
        userBoardList.value = [];
      }
      hasNextPage.value = userBoardsEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = userBoardsEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  Future<void> refreshData() async {
    userBoardList.clear();
    endCursor.value = '';
    await getUserBoards();
  }

  void goToPersonalInformationPage(String id) {
    Get.toNamed('${Routes.personalInformation}?id=$id');
  }
}
