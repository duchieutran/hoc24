import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/books_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class BooksController extends BaseController {
  String nameSubject = '';
  int idSubject = 0;
  RxList<BooksEntity> booksList = <BooksEntity>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    final args = Get.arguments as Map<String, dynamic>;
    nameSubject = args['nameSubject'] ?? '';
    idSubject = args['idSubject'] ?? 0;

    await getBooks();
    super.onInit();
  }


  Future<void> getBooks() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(
          grades: [appController.grade.value],
          subjects: [idSubject],
        ),
        grade: appController.grade.value,
        subject: idSubject,
      );
      booksList.value = await graphQLService.getBooks(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }
}
