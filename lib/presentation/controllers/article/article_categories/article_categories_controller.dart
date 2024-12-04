import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/article_categories_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class ArticleCategoriesController extends BaseController {
  RxList<ArticleCategoriesEntity> articleCategoriesList = <ArticleCategoriesEntity>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await getArticleCategories();
    super.onInit();
  }

  Future<void> getArticleCategories() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(),
        limitFeatureArticle: 4,
      );
      articleCategoriesList.value = await graphQLService.getArticleCategories(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
  }

  void onTapDetail(int idCategory, String title) {
    Get.toNamed(
      Routes.articles,
      arguments: {
        'idCategory': idCategory,
        'title': title,
      },
    );
  }

  void goToArticlesDetailPage(String id) {
    Get.toNamed(
      Routes.articlesDetail,
      arguments: {
        'id': id,
      },
    );
  }
}
