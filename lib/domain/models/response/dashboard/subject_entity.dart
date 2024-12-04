// To parse this JSON data, do
//
//     final subjectEntity = subjectEntityFromJson(jsonString);

class SubjectEntity {
  int? id;
  String? name;
  String? alias;
  int? mingrade;
  int? maxgrade;
  int? publish;
  List<int>? old;
  List<int>? subjectEntityNew;
  List<Book>? books;

  SubjectEntity({
    this.id,
    this.name,
    this.alias,
    this.mingrade,
    this.maxgrade,
    this.publish,
    this.old,
    this.subjectEntityNew,
    this.books,
  });

  factory SubjectEntity.fromJson(Map<String, dynamic> json) => SubjectEntity(
        id: json["id"],
        name: json["name"],
        alias: json["alias"],
        mingrade: json["mingrade"],
        maxgrade: json["maxgrade"],
        publish: json["publish"],
        old: json["old"] == null ? [] : List<int>.from(json["old"]!.map((x) => x)),
        subjectEntityNew: json["new"] == null ? [] : List<int>.from(json["new"]!.map((x) => x)),
        books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
      );
}

class Book {
  int? id;
  String? name;

  Book({
    this.id,
    this.name,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["_id"],
        name: json["name"],
      );
}
