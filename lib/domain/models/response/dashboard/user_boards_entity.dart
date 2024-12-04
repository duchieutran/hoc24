// To parse this JSON data, do
//
//     final userBoardsEntity = userBoardsEntityFromJson(jsonString);

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

class UserBoardsEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  UserBoardsEntity({
    this.edges,
    this.pageInfo,
  });

  factory UserBoardsEntity.fromJson(Map<String, dynamic> json) => UserBoardsEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );
}

class Edge {
  UserBoardNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : UserBoardNode.fromJson(json["node"]),
      );
}

class UserBoardNode {
  int? idSubject;
  int? sweek;
  int? smonth;
  String? iduser;
  int? sumAll;
  String? typed;
  UserEntity? userEntity;

  UserBoardNode({
    this.idSubject,
    this.sweek,
    this.smonth,
    this.iduser,
    this.sumAll,
    this.typed,
    this.userEntity,
  });

  factory UserBoardNode.fromJson(Map<String, dynamic> json) => UserBoardNode(
        idSubject: json["id_subject"],
        sweek: json["sweek"],
        smonth: json["smonth"],
        iduser: json["iduser"],
        sumAll: json["sum_all"],
        typed: json["typed"],
        userEntity: json["user"] == null ? null : UserEntity.fromJson(json["user"]),
      );
}
