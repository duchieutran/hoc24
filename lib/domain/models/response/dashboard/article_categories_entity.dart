// To parse this JSON data, do
//
//     final articleCategoriesEntity = articleCategoriesEntityFromJson(jsonString);

import 'article_entity.dart';

class ArticleCategoriesEntity {
  int? id;
  String? title;
  String? alias;
  String? description;
  List<ArticleNode>? featureArticle;

  ArticleCategoriesEntity({
    this.id,
    this.title,
    this.alias,
    this.description,
    this.featureArticle,
  });

  factory ArticleCategoriesEntity.fromJson(Map<String, dynamic> json) => ArticleCategoriesEntity(
        id: json["id"],
        title: json["title"],
        alias: json["alias"],
        description: json["description"],
        featureArticle: json["feature_article"] == null
            ? []
            : List<ArticleNode>.from(json["feature_article"]!.map((x) => ArticleNode.fromJson(x))),
      );
}
