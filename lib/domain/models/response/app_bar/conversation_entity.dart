// To parse this JSON data, do
//
//     final conversationEntity = conversationEntityFromJson(jsonString);

import 'dart:convert';

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

ConversationEntity conversationEntityFromJson(String str) => ConversationEntity.fromJson(json.decode(str));

String conversationEntityToJson(ConversationEntity data) => json.encode(data.toJson());

class ConversationEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  ConversationEntity({
    this.edges,
    this.pageInfo,
  });

  factory ConversationEntity.fromJson(Map<String, dynamic> json) => ConversationEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null ? [] : List<dynamic>.from(edges!.map((x) => x.toJson())),
        "pageInfo": pageInfo?.toJson(),
      };
}

class Edge {
  ConversationNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : ConversationNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class ConversationNode {
  UserEntity? infoFromUser;
  UserEntity? infoToUser;
  String? lastmess;
  int? countmess;
  int? created;
  int? block;

  ConversationNode({
    this.infoFromUser,
    this.infoToUser,
    this.lastmess,
    this.countmess,
    this.created,
    this.block,
  });

  factory ConversationNode.fromJson(Map<String, dynamic> json) => ConversationNode(
        infoFromUser: json["info_from_user"] == null ? null : UserEntity.fromJson(json["info_from_user"]),
        infoToUser: json["info_to_user"] == null ? null : UserEntity.fromJson(json["info_to_user"]),
        lastmess: json["lastmess"],
        countmess: json["countmess"],
        created: json["created"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "info_from_user": infoFromUser?.toJson(),
        "info_to_user": infoToUser?.toJson(),
        "lastmess": lastmess,
        "countmess": countmess,
        "created": created,
        "block": block,
      };
}
