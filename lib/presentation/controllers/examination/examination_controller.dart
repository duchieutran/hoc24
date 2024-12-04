import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/examination_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExaminationController extends BaseController {
  RxList<ExaminationNode> examinationList = <ExaminationNode>[].obs;
  RxBool hasNextPage = false.obs;
  RxString endCursor = ''.obs;
  final ScrollController scrollController = ScrollController();
  DateTime dateNow = DateTime.now();

  final TextEditingController subjectController = TextEditingController(text: 'Tất cả');
  final TextEditingController gradeController = TextEditingController();
  Rx<SubjectEntity> selectedSubject = SubjectEntity().obs;
  RxInt selectedGrade = 0.obs;
  List<SubjectEntity> subjectList = [];
  List<int> gradeList = List.generate(12, (index) => index + 1);

  @override
  Future<void> onInit() async {
    selectedGrade.value = appController.grade.value;
    scrollController.addListener(scrollListener);
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    await Future.wait([
      getSubjects(),
      getExamination(),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> getSubjects() async {
    try {
      GetDataRequest data = GetDataRequest(grade: selectedGrade.value, typeBook: 'NEW');
      subjectList = await graphQLService.getSubjects(getDataRequest: data);
      SubjectEntity subjectEntity = SubjectEntity(name: 'Tất cả', id: 0);
      subjectList.insert(0, subjectEntity);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> getExamination() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(
          idGrade: selectedGrade.value != 0 ? selectedGrade.value : null,
          idSubject: selectedSubject.value.id != 0 ? selectedSubject.value.id : null,
        ),
        pagination: Pagination(sorted: 'id', direction: 'desc'),
        after: endCursor.value,
        accessToken: appController.accessToken ?? '',
      );
      ExaminationEntity examinationEntity = await graphQLService.getExamination(getDataRequest: data);
      if (examinationEntity.edges != null) {
        examinationList.value += examinationEntity.edges!
            .map((edge) => edge.node)
            .where((node) => node != null)
            .cast<ExaminationNode>()
            .toList();
      } else {
        examinationList.value = [];
      }
      hasNextPage.value = examinationEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = examinationEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        hasNextPage.value) {
      getExamination();
    }
  }

  Future<void> refreshData() async {
    examinationList.clear();
    endCursor.value = '';
    await getExamination();
  }

  void goToExaminationDetailPage(String id) {
    Get.toNamed(
      Routes.examinationDetail,
      arguments: {
        'id': id,
      },
    );
  }
}
