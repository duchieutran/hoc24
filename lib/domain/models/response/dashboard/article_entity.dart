// To parse this JSON data, do
//
//     final articlesEntity = articlesEntityFromJson(jsonString);

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';

class ArticlesEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  ArticlesEntity({
    this.edges,
    this.pageInfo,
  });

  factory ArticlesEntity.fromJson(Map<String, dynamic> json) => ArticlesEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );
}

class Edge {
  ArticleNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : ArticleNode.fromJson(json["node"]),
      );
}

class ArticleNode {
  int? id;
  String? title;
  String? content;
  String? abs;
  String? author;
  int? created;
  int? idCategory;
  int? status;
  int? access;
  int? feature;
  int? publicComment;
  String? thumb;

  ArticleNode({
    this.id,
    this.title,
    this.content,
    this.abs,
    this.author,
    this.created,
    this.idCategory,
    this.status,
    this.access,
    this.feature,
    this.publicComment,
    this.thumb,
  });

  factory ArticleNode.fromJson(Map<String, dynamic> json) => ArticleNode(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        abs: json["abs"],
        author: json["author"],
        created: json["created"],
        idCategory: json["id_category"],
        status: json["status"],
        access: json["access"],
        feature: json["feature"],
        publicComment: json["public_comment"],
        thumb: json["thumb"],
      );
}
