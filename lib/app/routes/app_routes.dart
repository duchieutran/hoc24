part of './app_pages.dart';

abstract class Routes {
  static String root = "/";

  // Auth
  static String signup = "/signup";
  static String login = "/login";

  // Home
  static String fillInformation = "/fill-information";
  static String home = "/home";

  // App bar
  static String notification = "/notification";
  static String conversation = "/conversation";
  static String chat = "/chat";

  // Dashboard
  static String books = "/books";
  static String categories = "/categories";
  static String lessonDetail = "/lesson-detail";
  static String userBoards = "/user-boards";
  static String examination = "/examination";
  static String examinationDetail = "/examination-detail";
  static String articleCategories = "/article-categories";
  static String articles = "/articles";
  static String articlesDetail = "/articles-detail";

  // Q&A
  static String questionAnswer = "/question-answer";

  // Profile
  static String personalInformation = "/personal-information";
  static String editPersonalInformation = "/edit-personal";
  static String personalQA = "/personal-q-a";
  static String followers = "/followers";
  static String darkMode = "/dark-mode";
  static String changePassword = "/change-password";
}
