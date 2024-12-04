// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'dart:convert';

String updateUserRequestToJson(UpdateUserRequest data) => json.encode(data.toJson());

class UpdateUserRequest {
  FormUpdateUser formUpdateUser;
  String accessToken;

  UpdateUserRequest({
    required this.formUpdateUser,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() => {"formUpdateUser": formUpdateUser.toJson(), "access_token": accessToken};
}

class FormUpdateUser {
  List<int>? grades;
  String? password;
  String? oldPassword;
  String? tel;

  FormUpdateUser({
    this.grades,
    this.password,
    this.oldPassword,
    this.tel,
  });

  Map<String, dynamic> toJson() => {
        if (grades != null) "grades": grades == null ? [] : List<dynamic>.from(grades!.map((x) => x)),
        if (password != null) "password": password,
        if (oldPassword != null) "oldPassword": oldPassword,
        if (tel != null) "tel": tel
      };
}
