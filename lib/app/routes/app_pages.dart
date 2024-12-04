import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/presentation/controllers/article/article_categories/article_categories_binding.dart';
import 'package:hoc24/presentation/controllers/article/articles/articles_binding.dart';
import 'package:hoc24/presentation/controllers/article/articles_detail/articles_detail_binding.dart';
import 'package:hoc24/presentation/controllers/auth/login/login_binding.dart';
import 'package:hoc24/presentation/controllers/auth/signup/signup_binding.dart';
import 'package:hoc24/presentation/controllers/examination/examination_binding.dart';
import 'package:hoc24/presentation/controllers/examination/examination_detail/examination_detail_binding.dart';
import 'package:hoc24/presentation/controllers/home/home_binding.dart';
import 'package:hoc24/presentation/controllers/message/chat_binding.dart';
import 'package:hoc24/presentation/controllers/message/conversation_binding.dart';
import 'package:hoc24/presentation/controllers/notification/notification_binding.dart';
import 'package:hoc24/presentation/controllers/profile/change_password/change_password_binding.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/edit_personal_information/edit_personal_information_binding.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/followers/followers_binding.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/personal_information_binding.dart';
import 'package:hoc24/presentation/controllers/profile/personal_information/personal_questions/personal_questions_binding.dart';
import 'package:hoc24/presentation/controllers/subject/books/books_binding.dart';
import 'package:hoc24/presentation/controllers/subject/categories/categories_binding.dart';
import 'package:hoc24/presentation/controllers/subject/lesson_detail/lesson_detail_binding.dart';
import 'package:hoc24/presentation/controllers/user_boards/user_boards_binding.dart';
import 'package:hoc24/presentation/pages/article/article_categories/article_categories_page.dart';
import 'package:hoc24/presentation/pages/article/articles/articles_page.dart';
import 'package:hoc24/presentation/pages/article/articles_detail/articles_detail_page.dart';
import 'package:hoc24/presentation/pages/auth/login/login_page.dart';
import 'package:hoc24/presentation/pages/auth/signup/signup_page.dart';
import 'package:hoc24/presentation/pages/dashboard/fill_information_page.dart';
import 'package:hoc24/presentation/pages/examination/examination_detail_page.dart';
import 'package:hoc24/presentation/pages/examination/examination_page.dart';
import 'package:hoc24/presentation/pages/home/home_page.dart';
import 'package:hoc24/presentation/pages/message/chat/chat_page.dart';
import 'package:hoc24/presentation/pages/message/conversation/conversation_page.dart';
import 'package:hoc24/presentation/pages/notification/notification_page.dart';
import 'package:hoc24/presentation/pages/profile/change_password_page.dart';
import 'package:hoc24/presentation/pages/profile/dark_mode_page.dart';
import 'package:hoc24/presentation/pages/profile/personal_information/edit_personal_information_page.dart';
import 'package:hoc24/presentation/pages/profile/personal_information/followers_page.dart';
import 'package:hoc24/presentation/pages/profile/personal_information/personal_information_page.dart';
import 'package:hoc24/presentation/pages/profile/personal_information/personal_questions_page.dart';
import 'package:hoc24/presentation/pages/subject/books/books_page.dart';
import 'package:hoc24/presentation/pages/subject/categories/categories_page.dart';
import 'package:hoc24/presentation/pages/subject/lesson_detail/lesson_detail_page.dart';
import 'package:hoc24/presentation/pages/user_boards/user_boards_page.dart';

import '../middlewares/redirect_middleware.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.root,
      middlewares: [
        RedirectMiddleware(),
      ],
      page: () => Container(),
    ),

    // Auth
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),

    // Home
    GetPage(
      name: Routes.fillInformation,
      page: () => const FillInformationPage(),
    ),
    GetPage(
      name: Routes.home,
      middlewares: [
        RedirectMiddleware(),
      ],
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // App bar
    GetPage(
      name: Routes.notification,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.conversation,
      page: () => const ConversationPage(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),

    // Dashboard
    GetPage(
      name: Routes.books,
      page: () => const BooksPage(),
      binding: BooksBinding(),
    ),
    GetPage(
      name: Routes.categories,
      page: () => const CategoriesPage(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.lessonDetail,
      page: () => const LessonDetailPage(),
      binding: LessonDetailBinding(),
    ),
    GetPage(
      name: Routes.userBoards,
      page: () => const UserBoardsPage(),
      binding: UserBoardsBinding(),
    ),
    GetPage(
      name: Routes.examination,
      page: () => const ExaminationPage(),
      binding: ExaminationBinding(),
    ),
    GetPage(
      name: Routes.examinationDetail,
      page: () => const ExaminationDetailPage(),
      binding: ExaminationDetailBinding(),
    ),
    GetPage(
      name: Routes.articleCategories,
      page: () => const ArticleCategoriesPage(),
      binding: ArticleCategoriesBinding(),
    ),
    GetPage(
      name: Routes.articles,
      page: () => const ArticlesPage(),
      binding: ArticlesBinding(),
    ),
    GetPage(
      name: Routes.articlesDetail,
      page: () => const ArticlesDetailPage(),
      binding: ArticlesDetailBinding(),
    ),

    // Q&A
    GetPage(
      name: Routes.questionAnswer,
      page: () => const ArticlesPage(),
      // binding: ArticlesBinding(),
    ),

    // Personal
    GetPage(
      name: Routes.editPersonalInformation,
      page: () => const EditPersonalInformationPage(),
      binding: EditPersonalInformationBinding(),
    ),
    GetPage(
      name: Routes.personalInformation,
      page: () => const PersonalInformationPage(),
      binding: PersonalInformationBinding(),
    ),
    GetPage(
      name: Routes.personalQA,
      page: () => const PersonalQuestionsPage(),
      binding: PersonalQuestionsBinding(),
    ),
    GetPage(
      name: Routes.followers,
      page: () => const FollowersPage(),
      binding: FollowersBinding(),
    ),
    GetPage(
      name: Routes.darkMode,
      page: () => const DarkModePage(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
  ];
}

void routingCallback(Routing? routing) {
  if (routing?.current == null) {
    return;
  }
  RxRoute().currentRoute.value = routing?.current ?? '';
}

class RxRoute {
  final Rx<String> currentRoute = ''.obs;

  // Private constructor
  RxRoute._internal();

  // The single instance
  static final RxRoute _instance = RxRoute._internal();

  // Factory constructor to return the instance
  factory RxRoute() {
    return _instance;
  }
}
