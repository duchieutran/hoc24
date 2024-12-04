// To parse this JSON data, do
//
//     final userBoardsRequest = userBoardsRequestFromJson(jsonString);

class UpdateNotificationRequest {
  FormUpdateNotification? formUpdateNotification;
  String? accessToken;

  UpdateNotificationRequest({
    this.formUpdateNotification,
    this.accessToken,
  });

  Map<String, dynamic> toJson() => {
        "formUpdateNoti": formUpdateNotification?.toJson(),
        "access_token": accessToken,
      };
}

class FormUpdateNotification {
  List<int>? ids;
  String? status;

  FormUpdateNotification({
    this.ids,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "ids": ids == null ? [] : List<int>.from(ids!.map((x) => x)),
        "status": status,
      };
}
