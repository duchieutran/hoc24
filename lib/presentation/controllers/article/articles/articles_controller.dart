import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/article_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class ArticlesController extends BaseController {
  RxList<ArticleNode> articleNodeList = <ArticleNode>[].obs;
  RxBool hasNextPage = false.obs;
  RxString endCursor = ''.obs;
  int idCategory = 0;
  String title = '';
  final ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    final args = Get.arguments as Map<String, dynamic>;
    idCategory = args['idCategory'] ?? 0;
    title = args['title'] ?? '';

    scrollController.addListener(scrollListener);
    await Future.wait([
      getArticles(),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        hasNextPage.value) {
      getArticles();
    }
  }

  Future<void> getArticles() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(idCategory: idCategory),
        after: endCursor.value,
      );
      ArticlesEntity articlesEntity = await graphQLService.getArticles(getDataRequest: data);
      if (articlesEntity.edges != null) {
        articleNodeList.value +=
            articlesEntity.edges!.map((edge) => edge.node).where((node) => node != null).cast<ArticleNode>().toList();
      } else {
        articleNodeList.value = [];
      }
      hasNextPage.value = articlesEntity.pageInfo?.hasNextPage ?? false;
      endCursor.value = articlesEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    } finally {
      pageLoadingOff();
    }
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
