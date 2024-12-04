import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/helpers/handle_exception_helper.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/request/get/get_data_request.dart';
import 'package:hoc24/domain/models/response/dashboard/follower_entity.dart';
import 'package:hoc24/presentation/controllers/base_controller.dart';

class FollowersController extends BaseController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt tabIndex = 0.obs;

  RxList<FollowerNode> followerList = <FollowerNode>[].obs;
  RxList<FollowerNode> followingList = <FollowerNode>[].obs;

  RxBool hasNextPageFollower = false.obs;
  RxBool hasNextPageFollowing = false.obs;
  RxString endCursorFollower = ''.obs;
  RxString endCursorFollowing = ''.obs;
  final ScrollController scrollControllerFollower = ScrollController();
  final ScrollController scrollControllerFollowing = ScrollController();

  String id = '';
  String name = '';

  @override
  Future<void> onInit() async {
    final args = Get.arguments as Map<String, dynamic>;
    tabIndex.value = args['index'] ?? 0;
    id = args['id'] ?? '';
    name = args['name'] ?? '';

    tabController = TabController(length: 2, vsync: this, initialIndex: tabIndex.value);
    tabController.addListener(updateTabIndex);

    scrollControllerFollower.addListener(() => scrollListener(scrollControllerFollower, hasNextPageFollower.value));
    scrollControllerFollowing.addListener(() => scrollListener(scrollControllerFollowing, hasNextPageFollowing.value));

    pageLoadingOn();
    await Future.wait([
      getFollowers(),
      getFollowing(),
    ]);
    pageLoadingOff();
    super.onInit();
  }

  @override
  void onClose() {
    scrollControllerFollower.dispose();
    scrollControllerFollowing.dispose();
    super.onClose();
  }

  Future<void> scrollListener(ScrollController scrollController, bool hasNextPage) async {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200 &&
        !pageLoading &&
        hasNextPage) {
      pageLoadingOn();
      isFollower ? await getFollowers() : await getFollowing();
      pageLoadingOff();
    }
  }

  void updateTabIndex() {
    tabIndex.value = tabController.index;
  }

  Future<void> getFollowers() async {
    try {
      GetDataRequest data = GetDataRequest(
        filter: Filter(idUser: id, type: 'FOLLOWER'),
        after: endCursorFollower.value,
        accessToken: appController.accessToken ?? '',
      );
      FollowerEntity followerEntity = await graphQLService.getFollowers(getDataRequest: data);
      if (followerEntity.edges != null) {
        followerList.value +=
            followerEntity.edges!.map((edge) => edge.node).where((node) => node != null).cast<FollowerNode>().toList();
      } else {
        followerList.value = [];
      }
      hasNextPageFollower.value = followerEntity.pageInfo?.hasNextPage ?? false;
      endCursorFollower.value = followerEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> getFollowing() async {
    try {
      pageLoadingOn();
      GetDataRequest data = GetDataRequest(
        filter: Filter(idUser: id, type: 'FOLLOWING'),
        after: endCursorFollowing.value,
        accessToken: appController.accessToken ?? '',
      );
      FollowerEntity followerEntity = await graphQLService.getFollowers(getDataRequest: data);
      if (followerEntity.edges != null) {
        followingList.value +=
            followerEntity.edges!.map((edge) => edge.node).where((node) => node != null).cast<FollowerNode>().toList();
      } else {
        followingList.value = [];
      }
      hasNextPageFollowing.value = followerEntity.pageInfo?.hasNextPage ?? false;
      endCursorFollowing.value = followerEntity.pageInfo?.endCursor ?? '';
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  Future<void> followUser(String id) async {
    try {
      GetDataRequest data = GetDataRequest(
        iduser: id,
        accessToken: appController.accessToken ?? '',
      );
      await graphQLService.followUser(getDataRequest: data);
    } catch (error) {
      HandleExceptionHelper.graphql(error);
    }
  }

  void onFollow(int index) {
    String id = isFollower ? followerList[index].userFollower?.id ?? '' : followingList[index].userFollowing?.id ?? '';
    followUser(id);

    isFollower
        ? followerList[index] = followerList[index].copyWith(
            userFollower: followerList[index].userFollower?.copyWith(
                  userInfo: followerList[index].userFollower?.userInfo?.copyWith(
                        isFollow: !(followerList[index].userFollower?.userInfo?.isFollow ?? false),
                      ),
                ),
          )
        : followingList[index] = followingList[index].copyWith(
            userFollowing: followingList[index].userFollowing?.copyWith(
                  userInfo: followingList[index].userFollowing?.userInfo?.copyWith(
                        isFollow: !(followingList[index].userFollowing?.userInfo?.isFollow ?? false),
                      ),
                ),
          );
  }

  void goToPersonalInformationPage(String id) {
    Get.toNamed('${Routes.personalInformation}?id=$id');
  }

  bool get isFollower => tabIndex.value == 0;
}
