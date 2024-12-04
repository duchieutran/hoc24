// To parse this JSON data, do
//
//     final subjectEntity = subjectEntityFromJson(jsonString);

class BooksEntity {
  int? id;
  String? name;
  String? alias;
  List<int>? grades;
  List<int>? subjects;
  Info? info;

  BooksEntity({
    this.id,
    this.name,
    this.alias,
    this.grades,
    this.subjects,
    this.info,
  });

  factory BooksEntity.fromJson(Map<String, dynamic> json) => BooksEntity(
        id: json["_id"],
        name: json["name"],
        alias: json["alias"],
        grades: json["grades"] == null ? [] : List<int>.from(json["grades"]!.map((x) => x)),
        subjects: json["subjects"] == null ? [] : List<int>.from(json["subjects"]!.map((x) => x)),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
      );
}

class Info {
  int? countChapter;
  int? countLesson;

  Info({
    this.countChapter,
    this.countLesson,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        countChapter: json["count_chapter"],
        countLesson: json["count_lesson"],
      );
}
