// To parse this JSON data, do
//
//     final userBoardsRequest = userBoardsRequestFromJson(jsonString);

class SendMessageRequest {
  FormCreateMessage? formCreateMessage;
  String? accessToken;

  SendMessageRequest({
    required this.formCreateMessage,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() => {"formCreateMessage": formCreateMessage?.toJson(), "access_token": accessToken};
}

class FormCreateMessage {
  String? content;
  String? receive;

  FormCreateMessage({
    this.content,
    this.receive,
  });

  Map<String, dynamic> toJson() => {"content": content, "receive": receive};
}
