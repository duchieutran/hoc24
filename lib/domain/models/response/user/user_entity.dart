import 'dart:convert';

class UserEntity {
  String? id; // _id
  String? ip;
  String? site;
  String? background;
  String? usertype;
  int? block;
  int? sendemail;
  String? token;
  int? timeToken;
  String? emailParent;
  String? setting;
  String? images;
  String? logs;
  int? teacher;
  String? rememberToken;
  String? parentName;
  int? active;
  int? subscribe;
  String? idTenant;
  int? updateTime;
  int? notchat;
  List<int>? grades;
  int? blockDiscuss;
  int? blockPost;
  int? blockCourse;
  String? idsale;
  String? tel;
  int? verifyTel;
  String? manageBlock;
  String? state;
  int? support;
  int? isChangePass;
  int? userId; // id
  int? idUser;
  String? name;
  String? username;
  String? usernameHoc24;
  String? email;
  DateTime? registerdate;
  DateTime? lastvisitdate;
  int? registertime;
  int? lastvisittime;
  int? closed;
  UserInfo? userInfo;

  UserEntity({
    this.id,
    this.ip,
    this.site,
    this.background,
    this.usertype,
    this.block,
    this.sendemail,
    this.token,
    this.timeToken,
    this.emailParent,
    this.setting,
    this.images,
    this.logs,
    this.teacher,
    this.rememberToken,
    this.parentName,
    this.active,
    this.subscribe,
    this.idTenant,
    this.updateTime,
    this.notchat,
    this.grades,
    this.blockDiscuss,
    this.blockPost,
    this.blockCourse,
    this.idsale,
    this.tel,
    this.verifyTel,
    this.manageBlock,
    this.state,
    this.support,
    this.isChangePass,
    this.userId,
    this.idUser,
    this.name,
    this.username,
    this.usernameHoc24,
    this.email,
    this.registerdate,
    this.lastvisitdate,
    this.registertime,
    this.lastvisittime,
    this.closed,
    this.userInfo,
  });

  UserEntity copyWith({
    String? id, // _id
    String? ip,
    String? site,
    String? background,
    String? usertype,
    int? block,
    int? sendemail,
    String? token,
    int? timeToken,
    String? emailParent,
    String? setting,
    String? images,
    String? logs,
    int? teacher,
    String? rememberToken,
    String? parentName,
    int? active,
    int? subscribe,
    String? idTenant,
    int? updateTime,
    int? notchat,
    List<int>? grades,
    int? blockDiscuss,
    int? blockPost,
    int? blockCourse,
    String? idsale,
    String? tel,
    int? verifyTel,
    String? manageBlock,
    String? state,
    int? support,
    int? isChangePass,
    int? userId, // id
    int? idUser,
    String? name,
    String? username,
    String? usernameHoc24,
    String? email,
    DateTime? registerdate,
    DateTime? lastvisitdate,
    int? registertime,
    int? lastvisittime,
    int? closed,
    UserInfo? userInfo,
  }) =>
      UserEntity(
        id: id ?? this.id,
        ip: ip ?? this.ip,
        site: site ?? this.site,
        background: background ?? this.background,
        usertype: usertype ?? this.usertype,
        block: block ?? this.block,
        sendemail: sendemail ?? this.sendemail,
        token: token ?? this.token,
        timeToken: timeToken ?? this.timeToken,
        emailParent: emailParent ?? this.emailParent,
        setting: setting ?? this.setting,
        images: images ?? this.images,
        logs: logs ?? this.logs,
        teacher: teacher ?? this.teacher,
        rememberToken: rememberToken ?? this.rememberToken,
        parentName: parentName ?? this.parentName,
        active: active ?? this.active,
        subscribe: subscribe ?? this.subscribe,
        idTenant: idTenant ?? this.idTenant,
        updateTime: updateTime ?? this.updateTime,
        notchat: notchat ?? this.notchat,
        grades: grades ?? this.grades,
        blockDiscuss: blockDiscuss ?? this.blockDiscuss,
        blockPost: blockPost ?? this.blockPost,
        blockCourse: blockCourse ?? this.blockCourse,
        idsale: idsale ?? this.idsale,
        tel: tel ?? this.tel,
        verifyTel: verifyTel ?? this.verifyTel,
        manageBlock: manageBlock ?? this.manageBlock,
        state: state ?? this.state,
        support: support ?? this.support,
        isChangePass: isChangePass ?? this.isChangePass,
        userId: userId ?? this.userId,
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        username: username ?? this.username,
        usernameHoc24: usernameHoc24 ?? this.usernameHoc24,
        email: email ?? this.email,
        registerdate: registerdate ?? this.registerdate,
        lastvisitdate: lastvisitdate ?? this.lastvisitdate,
        registertime: registertime ?? this.registertime,
        lastvisittime: lastvisittime ?? this.lastvisittime,
        closed: closed ?? this.closed,
        userInfo: userInfo ?? this.userInfo,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["_id"],
        ip: json["ip"],
        site: json["site"],
        background: json["background"],
        usertype: json["usertype"],
        block: json["block"],
        sendemail: json["sendemail"],
        token: json["token"],
        timeToken: json["time_token"],
        emailParent: json["email_parent"],
        setting: json["setting"],
        images: json["images"],
        logs: json["logs"],
        teacher: json["teacher"],
        rememberToken: json["remember_token"],
        parentName: json["parent_name"],
        active: json["active"],
        subscribe: json["subscribe"],
        idTenant: json["id_tenant"],
        updateTime: json["update_time"],
        notchat: json["notchat"],
        grades: json["grades"] == null ? [] : List<int>.from(json["grades"]!.map((x) => x)),
        blockDiscuss: json["block_discuss"],
        blockPost: json["block_post"],
        blockCourse: json["block_course"],
        idsale: json["idsale"],
        tel: json["tel"],
        verifyTel: json["verify_tel"],
        manageBlock: json["manage_block"],
        state: json["state"],
        support: json["support"],
        isChangePass: json["is_change_pass"],
        userId: json["id"],
        idUser: json["id_user"],
        name: json["name"],
        username: json["username"],
        usernameHoc24: json["username_hoc24"],
        email: json["email"] == null || json["email"] == ' '
            ? null
            : json["email"].toString().contains('@')
                ? json["email"]
                : utf8.decode(base64Decode(json["email"])),
        registerdate: json["registerdate"] == null ? null : DateTime.parse(json["registerdate"]),
        lastvisitdate: json["lastvisitdate"] == null ? null : DateTime.parse(json["lastvisitdate"]),
        registertime: json["registertime"],
        lastvisittime: json["lastvisittime"],
        closed: json["closed"],
        userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ip": ip,
        "site": site,
        "background": background,
        "usertype": usertype,
        "block": block,
        "sendemail": sendemail,
        "token": token,
        "time_token": timeToken,
        "email_parent": emailParent,
        "setting": setting,
        "images": images,
        "logs": logs,
        "teacher": teacher,
        "remember_token": rememberToken,
        "parent_name": parentName,
        "active": active,
        "subscribe": subscribe,
        "id_tenant": idTenant,
        "update_time": updateTime,
        "notchat": notchat,
        "grades": grades == null ? [] : List<int>.from(grades!.map((x) => x)),
        "block_discuss": blockDiscuss,
        "block_post": blockPost,
        "block_course": blockCourse,
        "idsale": idsale,
        "tel": tel,
        "verify_tel": verifyTel,
        "manage_block": manageBlock,
        "state": state,
        "support": support,
        "is_change_pass": isChangePass,
        "id": userId,
        "id_user": idUser,
        "name": name,
        "username": username,
        "username_hoc24": usernameHoc24,
        "email": email,
        "registerdate": registerdate?.toIso8601String(),
        "lastvisitdate": lastvisitdate?.toIso8601String(),
        "registertime": registertime,
        "lastvisittime": lastvisittime,
        "closed": closed,
        "userInfo": userInfo?.toJson(),
      };
}

class UserInfo {
  int? countQuestion;
  int? countAnswer;
  int? countFollower;
  int? countFollowing;
  int? scoreGp;
  int? scoreSp;
  int? countAward;
  String? school;
  String? city;
  bool? isFollow;

  UserInfo({
    this.countQuestion,
    this.countAnswer,
    this.countFollower,
    this.countFollowing,
    this.scoreGp,
    this.scoreSp,
    this.countAward,
    this.school,
    this.city,
    this.isFollow,
  });

  UserInfo copyWith({
    int? countQuestion,
    int? countAnswer,
    int? countFollower,
    int? countFollowing,
    int? scoreGp,
    int? scoreSp,
    int? countAward,
    String? school,
    String? city,
    bool? isFollow,
  }) =>
      UserInfo(
        countQuestion: countQuestion ?? this.countQuestion,
        countAnswer: countAnswer ?? this.countAnswer,
        countFollower: countFollower ?? this.countFollower,
        countFollowing: countFollowing ?? this.countFollowing,
        scoreGp: scoreGp ?? this.scoreGp,
        scoreSp: scoreSp ?? this.scoreSp,
        countAward: countAward ?? this.countAward,
        school: school ?? this.school,
        city: city ?? this.city,
        isFollow: isFollow ?? this.isFollow,
      );

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        countQuestion: json["count_question"],
        countAnswer: json["count_answer"],
        countFollower: json["count_follower"],
        countFollowing: json["count_following"],
        scoreGp: json["score_gp"],
        scoreSp: json["score_sp"],
        countAward: json["count_award"],
        school: json["school"],
        city: json["city"],
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "count_question": countQuestion,
        "count_answer": countAnswer,
        "count_follower": countFollower,
        "count_following": countFollowing,
        "score_gp": scoreGp,
        "score_sp": scoreSp,
        "count_award": countAward,
        "school": school,
        "city": city,
        "isFollow": isFollow,
      };
}
