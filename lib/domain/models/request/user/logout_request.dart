class LogoutRequest {
  final String? accessToken;

  LogoutRequest({this.accessToken});

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
