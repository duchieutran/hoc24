class GetUserRequest {
  final String idUser;
  final String? accessToken;

  GetUserRequest({
    required this.idUser,
    this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'iduser': idUser,
      if (accessToken != null) 'access_token': accessToken,
    };
  }
}
