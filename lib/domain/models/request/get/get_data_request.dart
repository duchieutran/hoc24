// To parse this JSON data, do
//
//     final userBoardsRequest = userBoardsRequestFromJson(jsonString);

class GetDataRequest {
  String? iduser;
  Filter? filter;
  Pagination? pagination;
  String? after;
  String? token;
  String? email;
  String? accessToken;
  int? grade;
  int? subject;
  int? limitFeatureArticle;
  int? first;
  String? typeBook;

  GetDataRequest({
    this.iduser,
    this.filter,
    this.pagination,
    this.token,
    this.accessToken,
    this.email,
    this.after,
    this.grade,
    this.subject,
    this.limitFeatureArticle,
    this.first,
    this.typeBook,
  });

  Map<String, dynamic> toJson() => {
        if (iduser != null) "iduser": iduser,
        if (filter != null) "filter": filter?.toJson(),
        if (pagination != null) "pagination": pagination?.toJson(),
        if (after != null) "after": after,
        if (token != null) "token": token,
        if (accessToken != null) "access_token": accessToken,
        if (email != null) "email": email,
        if (grade != null) 'grade': grade,
        if (subject != null) 'subject': subject,
        if (limitFeatureArticle != null) 'limit_feature_article': limitFeatureArticle,
        if (first != null) 'first': first,
        if (typeBook != null) 'type_book': typeBook,
      };
}

class Filter {
  String? idUser;
  int? idGrade;
  int? idSubject;
  List<int>? grades;
  List<int>? subjects;
  int? idCategory;
  String? receive;
  String? type;
  String? typed;
  int? idBook;
  int? idParent;
  int? readed;
  int? viewed;
  int? status;

  Filter({
    this.idUser,
    this.idGrade,
    this.idSubject,
    this.grades,
    this.subjects,
    this.idCategory,
    this.receive,
    this.type,
    this.typed,
    this.idBook,
    this.idParent,
    this.readed,
    this.viewed,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (idUser != null) "iduser": idUser,
        if (idGrade != null) "id_grade": idGrade,
        if (idSubject != null) "id_subject": idSubject,
        if (grades != null) "grades": List<dynamic>.from(grades!.map((x) => x)),
        if (subjects != null) "subjects": List<dynamic>.from(subjects!.map((x) => x)),
        if (idCategory != null) "id_category": idCategory,
        if (receive != null) "receive": receive,
        if (type != null) "type": type,
        if (typed != null) "typed": typed,
        if (idBook != null) "id_book": idBook,
        if (idParent != null) "id_parent": idParent,
        if (readed != null) "readed": readed,
        if (viewed != null) "viewed": viewed,
        if (status != null) "status": status,
      };
}

class Pagination {
  String? sorted;
  String? direction;

  Pagination({
    this.sorted,
    this.direction,
  });

  Map<String, dynamic> toJson() =>
      {if (sorted != null) "sorted": sorted, if (direction != null) "direction": direction};
}
