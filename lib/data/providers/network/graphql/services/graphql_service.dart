import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hoc24/data/providers/network/graphql/query_constants.dart';
import 'package:hoc24/domain/models/request/fetch/send_message_request.dart';
import 'package:hoc24/domain/models/request/fetch/update_message_request.dart';
import 'package:hoc24/domain/models/request/fetch/update_notification_request.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/request/user/get_user_request.dart';
import 'package:hoc24/domain/models/request/user/register_request.dart';
import 'package:hoc24/domain/models/request/user/update_user_request.dart';
import 'package:hoc24/domain/models/response/app_bar/chat_entity.dart';
import 'package:hoc24/domain/models/response/app_bar/conversation_entity.dart';
import 'package:hoc24/domain/models/response/app_bar/notification_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/article_categories_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/article_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/banner_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/books_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/categories_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/examination_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/follower_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';
import 'package:hoc24/domain/models/response/dashboard/user_boards_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

import '../graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();
  String errorMessage = "";

  Future<void> registerUser({
    required RegisterRequest registerRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(REGISTER_QUERY),
        variables: {
          'formRegisterUser': registerRequest.toJson(),
        },
      ),
    );
    _checkException(result);
  }

  Future<UserEntity> getUser({
    required GetUserRequest getUserRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_USER_QUERY),
        variables: getUserRequest.toJson(),
      ),
    );
    _checkException(result);
    UserEntity userEntity = UserEntity.fromJson(result.data?['getUser']);
    return userEntity;
  }

  Future<bool> updateUser({
    required UpdateUserRequest updateUserRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(UPDATE_USER_QUERY),
        variables: updateUserRequest.toJson(),
      ),
    );
    _checkException(result);
    bool resultData = result.data?['updateUser'];
    return resultData;
  }

  Future<bool> deleteAccount({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(DELETE_ACCOUNT_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    bool resultData = result.data?['deleteAccount'];
    return resultData;
  }

  Future<bool> sendMailForgetPassword({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(SEND_EMAIL_FORGET_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    bool resultData = result.data?['sendMailForgetPassword'];
    return resultData;
  }

  Future<NotificationEntity> getNotification({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_NOTIFICATION_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    NotificationEntity notificationEntity = NotificationEntity.fromJson(result.data?['fetchNoti']);
    return notificationEntity;
  }

  Future<int> getCountNotification({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_COUNT_NOTIFICATION_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    return result.data?['countNoti'];
  }

  Future<void> updateNotification({
    required UpdateNotificationRequest request,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(UPDATE_NOTIFICATION_QUERY),
        variables: request.toJson(),
      ),
    );
    _checkException(result);
  }

  Future<ConversationEntity> getConversation({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_CONVERSATION_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    ConversationEntity conversationEntity = ConversationEntity.fromJson(result.data?['fetchMessageItem']);
    return conversationEntity;
  }

  Future<ChatEntity> getChat({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_CHAT_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    ChatEntity chatEntity = ChatEntity.fromJson(result.data?['fetchMessage']);
    return chatEntity;
  }

  Future<void> sendMessage({
    required SendMessageRequest sendMessageRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(SEND_MESSAGE_QUERY),
        variables: sendMessageRequest.toJson(),
      ),
    );
    _checkException(result);
  }

  Future<int> getCountMessage({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_COUNT_MESSAGE_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    return result.data?['countMessage'];
  }

  Future<void> updateMessage({
    required UpdateMessageRequest request,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(UPDATE_MESSAGE_QUERY),
        variables: request.toJson(),
      ),
    );
    _checkException(result);
  }

  Future<List<BannerEntity>> getBanner() async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_BANNER_QUERY),
        variables: const {},
      ),
    );
    _checkException(result);
    List? res = result.data?['banner'];
    if (res == null || res.isEmpty) {
      return [];
    }
    List<BannerEntity> bannerList = res.map((banner) => BannerEntity.fromJson(banner)).toList();
    return bannerList;
  }

  Future<List<SubjectEntity>> getSubjects({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_SUBJECTS_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    List? res = result.data?['subjects'];
    if (res == null || res.isEmpty) {
      return [];
    }

    List<SubjectEntity> subjectList = res.map((subject) => SubjectEntity.fromJson(subject)).toList();
    return subjectList;
  }

  Future<List<BooksEntity>> getBooks({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_BOOKS_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    List? res = result.data?['books'];
    if (res == null || res.isEmpty) {
      return [];
    }

    List<BooksEntity> booksList = res.map((books) => BooksEntity.fromJson(books)).toList();
    return booksList;
  }

  Future<List<CategoriesEntity>> getCategories({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_CATEGORIES_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    List? res = result.data?['categories'];
    if (res == null || res.isEmpty) {
      return [];
    }

    List<CategoriesEntity> categoriesList = res.map((books) => CategoriesEntity.fromJson(books)).toList();
    return categoriesList;
  }

  Future<UserBoardsEntity> getUserBoards({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_USER_BOARDS_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    UserBoardsEntity userBoardsEntity = UserBoardsEntity.fromJson(result.data?['fetchUserBoards']);
    return userBoardsEntity;
  }

  Future<ExaminationEntity> getExamination({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_EXAMINATION_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    ExaminationEntity examinationEntity = ExaminationEntity.fromJson(result.data?['fetchExaminations']);
    return examinationEntity;
  }

  Future<List<ArticleCategoriesEntity>> getArticleCategories({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_ARTICLE_CATEGORIES_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    List? res = result.data?['articleCategories'];
    if (res == null || res.isEmpty) {
      return [];
    }

    List<ArticleCategoriesEntity> articleCategoriesList =
        res.map((articleCategories) => ArticleCategoriesEntity.fromJson(articleCategories)).toList();
    return articleCategoriesList;
  }

  Future<ArticlesEntity> getArticles({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_ARTICLES_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    ArticlesEntity articlesEntity = ArticlesEntity.fromJson(result.data?['fetchArticles']);
    return articlesEntity;
  }

  Future<FollowerEntity> getFollowers({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(GET_FOLLOWERS_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
    FollowerEntity followerEntity = FollowerEntity.fromJson(result.data?['fetchFollow']);
    return followerEntity;
  }

  Future<void> followUser({
    required GetDataRequest getDataRequest,
  }) async {
    QueryResult result = await client.mutate(
      MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(FOLLOW_USER_QUERY),
        variables: getDataRequest.toJson(),
      ),
    );
    _checkException(result);
  }

  // ERROR CHECKER
  _checkException(QueryResult result) {
    if (result.hasException) {
      final List<GraphQLError> errors = result.exception!.graphqlErrors;
      final LinkException? linkException = result.exception!.linkException;
      if (errors.isNotEmpty) {
        final Map<String, dynamic>? validationErrors = errors[0].extensions?['validation'];
        if (validationErrors != null) {
          errorMessage = validationErrors.values.map((value) => value[0]).join('\n');
        }
      } else if (linkException != null) {
        if (linkException.originalException is TimeoutException) {
          errorMessage = "Request timed out!";
        } else {
          errorMessage = linkException.originalException.toString() != "null"
              ? linkException.originalException.toString()
              : "Something went wrong!";
        }
      }
      if (errorMessage.isEmpty) {
        errorMessage = errors[0].message;
      }
      throw errorMessage;
    } else {
      // Logger.d('_handleResponse:$result');
    }
  }
}
