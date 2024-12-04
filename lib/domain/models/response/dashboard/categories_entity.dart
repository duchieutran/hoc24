// To parse this JSON data, do
//
//     final categoriesEntity = categoriesEntityFromJson(jsonString);

class CategoriesEntity {
  int? id;
  int? idSubject;
  String? title;
  int? idGrade;
  int? idParent;
  String? description;
  dynamic summary;
  int? order;
  int? countQuestions;
  int? countOther;
  int? countSgk;
  String? file;
  int? status;
  String? subCateUniversity;
  String? refered;
  int? testId;
  String? video;
  List<dynamic>? listq;
  int? complete;
  String? idContributeCategory;
  int? week;
  int? timed;
  int? typed;
  List<Child>? children;

  CategoriesEntity({
    this.id,
    this.idSubject,
    this.title,
    this.idGrade,
    this.idParent,
    this.description,
    this.summary,
    this.order,
    this.countQuestions,
    this.countOther,
    this.countSgk,
    this.file,
    this.status,
    this.subCateUniversity,
    this.refered,
    this.testId,
    this.video,
    this.listq,
    this.complete,
    this.idContributeCategory,
    this.week,
    this.timed,
    this.typed,
    this.children,
  });

  factory CategoriesEntity.fromJson(Map<String, dynamic> json) => CategoriesEntity(
        id: json["id"],
        idSubject: json["id_subject"],
        title: json["title"],
        idGrade: json["id_grade"],
        idParent: json["id_parent"],
        description: json["description"],
        summary: json["summary"],
        order: json["order"],
        countQuestions: json["count_questions"],
        countOther: json["count_other"],
        countSgk: json["count_sgk"],
        file: json["file"],
        status: json["status"],
        subCateUniversity: json["sub_cate_university"],
        refered: json["refered"],
        testId: json["test_id"],
        video: json["video"],
        listq: json["listq"] == null ? [] : List<dynamic>.from(json["listq"]!.map((x) => x)),
        complete: json["complete"],
        idContributeCategory: json["id_contribute_category"],
        week: json["week"],
        timed: json["timed"],
        typed: json["typed"],
        children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
      );
}

class Child {
  int? id;
  int? idParent;
  String? title;
  int? typed;
  int? status;
  int? complete;
  String? description;
  dynamic summary;
  int? order;
  int? countQuestions;
  int? countSgk;
  int? countOther;
  String? file;
  int? week;

  Child({
    this.id,
    this.idParent,
    this.title,
    this.typed,
    this.status,
    this.complete,
    this.description,
    this.summary,
    this.order,
    this.countQuestions,
    this.countSgk,
    this.countOther,
    this.file,
    this.week,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        idParent: json["id_parent"],
        title: json["title"],
        typed: json["typed"],
        status: json["status"],
        complete: json["complete"],
        description: json["description"],
        summary: json["summary"],
        order: json["order"],
        countQuestions: json["count_questions"],
        countSgk: json["count_sgk"],
        countOther: json["count_other"],
        file: json["file"],
        week: json["week"],
      );
}
