// To parse this JSON data, do
//
//     final userBoardsRequest = userBoardsRequestFromJson(jsonString);

class UpdateMessageRequest {
  FormUpdateMessage? formUpdateMessage;
  String? accessToken;

  UpdateMessageRequest({
    this.formUpdateMessage,
    this.accessToken,
  });

  Map<String, dynamic> toJson() => {
        "formUpdateMessage": formUpdateMessage?.toJson(),
        "access_token": accessToken,
      };
}

class FormUpdateMessage {
  String? send;
  int? readed;

  FormUpdateMessage({
    this.send,
    this.readed,
  });

  Map<String, dynamic> toJson() => {
        "send": send,
        "readed": readed,
      };
}
