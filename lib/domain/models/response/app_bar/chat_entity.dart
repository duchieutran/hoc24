// To parse this JSON data, do
//
//     final chatEntity = chatEntityFromJson(jsonString);

import 'dart:convert';

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';

ChatEntity chatEntityFromJson(String str) => ChatEntity.fromJson(json.decode(str));

String chatEntityToJson(ChatEntity data) => json.encode(data.toJson());

class ChatEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  ChatEntity({
    this.edges,
    this.pageInfo,
  });

  factory ChatEntity.fromJson(Map<String, dynamic> json) => ChatEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null ? [] : List<dynamic>.from(edges!.map((x) => x.toJson())),
        "pageInfo": pageInfo?.toJson(),
      };
}

class Edge {
  ChatNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : ChatNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class ChatNode {
  String? send;
  String? receive;
  int? created;
  int? readed;
  String? content;
  int? senddel;
  int? receivedel;

  ChatNode({
    this.send,
    this.receive,
    this.created,
    this.readed,
    this.content,
    this.senddel,
    this.receivedel,
  });

  factory ChatNode.fromJson(Map<String, dynamic> json) => ChatNode(
        send: json["send"],
        receive: json["receive"],
        created: json["created"],
        readed: json["readed"],
        content: json["content"],
        senddel: json["senddel"],
        receivedel: json["receivedel"],
      );

  Map<String, dynamic> toJson() => {
        "send": send,
        "receive": receive,
        "created": created,
        "readed": readed,
        "content": content,
        "senddel": senddel,
        "receivedel": receivedel,
      };
}
