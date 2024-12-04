// To parse this JSON data, do
//
//     final examinationEntity = examinationEntityFromJson(jsonString);

import 'package:hoc24/domain/models/response/data/page_info_entity.dart';
import 'package:hoc24/domain/models/response/user/user_entity.dart';

import 'subject_entity.dart';

class ExaminationEntity {
  List<Edge>? edges;
  PageInfo? pageInfo;

  ExaminationEntity({
    this.edges,
    this.pageInfo,
  });

  factory ExaminationEntity.fromJson(Map<String, dynamic> json) => ExaminationEntity(
        edges: json["edges"] == null ? [] : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
      );
}

class Edge {
  ExaminationNode? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : ExaminationNode.fromJson(json["node"]),
      );
}

class ExaminationNode {
  int? id;
  String? title;
  int? idSubject;
  int? idGrade;
  int? time;
  int? created;
  int? modified;
  int? exType;
  SubjectEntity? subjectEntity;
  UserEntity? user;

  ExaminationNode({
    this.id,
    this.title,
    this.idSubject,
    this.idGrade,
    this.time,
    this.created,
    this.modified,
    this.exType,
    this.subjectEntity,
    this.user,
  });

  factory ExaminationNode.fromJson(Map<String, dynamic> json) => ExaminationNode(
        id: json["id"],
        title: json["title"],
        idSubject: json["id_subject"],
        idGrade: json["id_grade"],
        time: json["time"],
        created: json["created"],
        modified: json["modified"],
        exType: json["ex_type"],
        subjectEntity: json["subject"] == null ? null : SubjectEntity.fromJson(json["subject"]),
        user: json["user"] == null ? null : UserEntity.fromJson(json["user"]),
      );
}
