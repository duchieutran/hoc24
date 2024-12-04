// To parse this JSON data, do
//
//     final followerEntity = followerEntityFromJson(jsonString);

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

class FollowerEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  FollowerEntity({
    this.edges,
    this.pageInfo,
  });

  factory FollowerEntity.fromJson(Map<String, dynamic> json) => FollowerEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );
}

class Edge {
  FollowerNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : FollowerNode.fromJson(json["node"]),
      );
}

class FollowerNode {
  int? id;
  UserEntity? userFollower;
  UserEntity? userFollowing;

  FollowerNode({
    this.id,
    this.userFollower,
    this.userFollowing,
  });

  FollowerNode copyWith({
    int? id,
    UserEntity? userFollower,
    UserEntity? userFollowing,
  }) =>
      FollowerNode(
        id: id ?? this.id,
        userFollower: userFollower ?? this.userFollower,
        userFollowing: userFollowing ?? this.userFollowing,
      );

  factory FollowerNode.fromJson(Map<String, dynamic> json) => FollowerNode(
        id: json["id"],
        userFollower: json["user_follower"] == null ? null : UserEntity.fromJson(json["user_follower"]),
        userFollowing: json["user_following"] == null ? null : UserEntity.fromJson(json["user_following"]),
      );
}
