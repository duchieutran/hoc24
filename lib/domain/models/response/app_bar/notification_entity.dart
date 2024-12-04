// To parse this JSON data, do
//
//     final notificationEntity = notificationEntityFromJson(jsonString);

import 'dart:convert';

import 'package:hoc24/domain/models/response/user/user_entity.dart';

import '../data/page_info_entity.dart';

NotificationEntity notificationEntityFromJson(String str) => NotificationEntity.fromJson(json.decode(str));

String notificationEntityToJson(NotificationEntity data) => json.encode(data.toJson());

class NotificationEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  NotificationEntity({
    this.edges,
    this.pageInfo,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => NotificationEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null ? [] : List<dynamic>.from(edges!.map((x) => x.toJson())),
        "pageInfo": pageInfo?.toJson(),
      };
}

class Edge {
  NotificationNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : NotificationNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class NotificationNode {
  int? id;
  String? fromUser;
  String? toUser;
  String? contentType;
  String? contentId;
  String? contentPa;
  int? created;
  int? viewed;
  String? other;
  String? url;
  int? idGroup;
  int? idCourseware;
  UserEntity? infoFromUser;
  UserEntity? infoToUser;
  InfoNoti? infoNoti;

  NotificationNode({
    this.id,
    this.fromUser,
    this.toUser,
    this.contentType,
    this.contentId,
    this.contentPa,
    this.created,
    this.viewed,
    this.other,
    this.url,
    this.idGroup,
    this.idCourseware,
    this.infoFromUser,
    this.infoToUser,
    this.infoNoti,
  });

  NotificationNode copyWith({
    int? id,
    String? fromUser,
    String? toUser,
    String? contentType,
    String? contentId,
    String? contentPa,
    int? created,
    int? viewed,
    String? other,
    String? url,
    int? idGroup,
    int? idCourseware,
    UserEntity? infoFromUser,
    UserEntity? infoToUser,
    InfoNoti? infoNoti,
  }) =>
      NotificationNode(
        id: id ?? this.id,
        fromUser: fromUser ?? this.fromUser,
        toUser: toUser ?? this.toUser,
        contentType: contentType ?? this.contentType,
        contentId: contentId ?? this.contentId,
        contentPa: contentPa ?? this.contentPa,
        created: created ?? this.created,
        viewed: viewed ?? this.viewed,
        other: other ?? this.other,
        url: url ?? this.url,
        idGroup: idGroup ?? this.idGroup,
        idCourseware: idCourseware ?? this.idCourseware,
        infoFromUser: infoFromUser ?? this.infoFromUser,
        infoToUser: infoToUser ?? this.infoToUser,
        infoNoti: infoNoti ?? this.infoNoti,
      );

  factory NotificationNode.fromJson(Map<String, dynamic> json) => NotificationNode(
        id: json["id"],
        fromUser: json["from_user"],
        toUser: json["to_user"],
        contentType: json["content_type"],
        contentId: json["content_id"],
        contentPa: json["content_pa"],
        created: json["created"],
        viewed: json["viewed"],
        other: json["other"],
        url: json["url"],
        idGroup: json["id_group"],
        idCourseware: json["id_courseware"],
        infoFromUser: json["info_from_user"] == null ? null : UserEntity.fromJson(json["info_from_user"]),
        infoToUser: json["info_to_user"] == null ? null : UserEntity.fromJson(json["info_to_user"]),
        infoNoti: json["info_noti"] == null ? null : InfoNoti.fromJson(json["info_noti"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_user": fromUser,
        "to_user": toUser,
        "content_type": contentType,
        "content_id": contentId,
        "content_pa": contentPa,
        "created": created,
        "viewed": viewed,
        "other": other,
        "url": url,
        "id_group": idGroup,
        "id_courseware": idCourseware,
        "info_from_user": infoFromUser?.toJson(),
        "info_to_user": infoToUser?.toJson(),
        "info_noti": infoNoti?.toJson(),
      };
}

class InfoNoti {
  String? icon;
  String? message;

  InfoNoti({
    this.icon,
    this.message,
  });

  factory InfoNoti.fromJson(Map<String, dynamic> json) => InfoNoti(
        icon: json["icon"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "message": message,
      };
}
