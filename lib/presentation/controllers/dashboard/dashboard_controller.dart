import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoc24/app/config/app_constants.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/article_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/banner_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class DashboardController extends BaseController {
  BannerAd? banner;
  InterstitialAd? interstitialAd;

  RxList<BannerEntity> bannerList = <BannerEntity>[].obs;
  RxList<SubjectEntity> subjectsList = <SubjectEntity>[].obs;
  RxList<ArticleNode> articleList = <ArticleNode>[].obs;

  final ScrollController scrollController = ScrollController();

  // final JavascriptRuntime javascriptRuntime = getJavascriptRuntime();
  // RxString jsResults = ''.obs;

  @override
  Future<void> onInit() async {
    pageLoadingOn();
    await Future.wait([
      getBanner(),
      getSubjects(),
      getArticles(),
    ]);
    pageLoadingOff();
    createInterstitial();
    createBannerAd();
    // await _executeJsFromFile();
    // print('JS Evaluate Result:\n${jsResults.value}\nHi');
    super.onInit();
  }

  // Future<void> _executeJsFromFile() async {
  //   try {
  //     // Đọc file .js từ assets
  //     String jsCode = await rootBundle.loadString('assets/kas.js');
  //
  //     // Thêm biểu thức KAS.parse
  //     jsCode +=
  //         "var eq1 = KAS.parse('2w+50/w=25').expr;var eq2 = KAS.parse('w(12.5-w)=25').expr;KAS.compare(eq1, eq2).equal";
  //
  //     // Thực thi mã JavaScript
  //     JsEvalResult result = javascriptRuntime.evaluate(jsCode);
  //
  //     jsResults.value = result.stringResult;
  //   } catch (e) {
  //     jsResults.value = 'Error: $e';
  //   }
  // }

  @override
  void onClose() {
    banner?.dispose();
    interstitialAd?.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void createBannerAd() {
    banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AppConstants.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) => debugPrint('Ad loaded'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('BannerAd failed to load: $error');
        },
        onAdOpened: (ad) => debugPrint('Ad opened'),
        onAdClosed: (ad) => debugPrint('Ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void createInterstitial() {
    InterstitialAd.load(
      adUnitId: AppConstants.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitial();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitial();
        },
      );
      interstitialAd?.show();
      interstitialAd = null;
    } else {
      createInterstitial();
    }
  }

  Future<void> getBanner() async {
    try {
      bannerList.value = await graphQLService.getBanner();
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> getSubjects() async {
    try {
      GetDataRequest data = GetDataRequest(grade: appController.grade.value, typeBook: 'NEW');
      subjectsList.value = await graphQLService.getSubjects(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  void onTap(String? name, int? id) {
    Get.toNamed(
      Routes.books,
      arguments: {
        'nameSubject': name,
        'idSubject': id,
      },
    );
  }

  void goToUserBoardsPage() {
    Get.toNamed(Routes.userBoards);
  }

  void goToExaminationPage() {
    Get.toNamed(Routes.examination);
  }

  void goToArticleCategoriesPage() {
    Get.toNamed(Routes.articleCategories);
  }

  void goToContestPage() {
    // showInterstitialAd();
  }

  Future<void> getArticles() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(),
        first: 5,
        accessToken: appController.accessToken ?? '',
      );
      ArticlesEntity articlesEntity = await graphQLService.getArticles(getDataRequest: data);
      if (articlesEntity.edges != null) {
        articleList.value +=
            articlesEntity.edges!.map((edge) => edge.node).where((node) => node != null).cast<ArticleNode>().toList();
      } else {
        articleList.value = [];
      }
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
